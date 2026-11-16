import json
import re
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path


repo, destination, swiftc = Path(sys.argv[1]), Path(sys.argv[2]), sys.argv[3]
cases = json.loads((repo / "oracle.json").read_text())["cases"]
assert len(cases) == 40
fixture = "Sources/Fixture.swift"
swift_version = subprocess.check_output([swiftc, "--version"], text=True).strip()
target = json.loads(subprocess.check_output([swiftc, "-print-target-info"], text=True))["target"]["triple"]

inputs = [-1, 0, 1, 5, 7, 8, 10, 11, 14]
calls = {
    "R7-P1": f"print({inputs}.map {{ tariff($0) }})",
    "R7-P2": f"print({inputs}.map {{ alert($0) }})",
    "R7-P3": f"print({inputs}.map {{ spread($0) }})",
    "R8-P1": 'print(sample().joined(separator: ","))',
    "R8-P2": 'print(sample(false).joined(separator: ",")); print(sample(true).joined(separator: ","))',
    "R8-P3": 'print(sample().joined(separator: ","))',
}
expected_logs = {
    "R8-P1": "acquire,work,release",
    "R8-P2": "acquire,work,release\nacquire,release",
    "R8-P3": "acquire,work,flush,release",
}


def run(args):
    result = subprocess.run(args, capture_output=True, text=True, timeout=90)
    return {"status": result.returncode, "stdout": result.stdout, "stderr": result.stderr}


def check_case(case):
    case_id = case["case_id"]
    revision_checks = {}
    for revision in ("before", "after"):
        source = subprocess.check_output(
            ["git", "-C", str(repo), "show", f"{case[revision + '_sha']}:{fixture}"], text=True
        )
        assert source == (repo / "cases" / case_id / revision / "Fixture.swift").read_text()
        with tempfile.TemporaryDirectory() as temp:
            temp = Path(temp)
            swift_file = temp / "Fixture.swift"
            swift_file.write_text(source)
            library = temp / "fixture.dylib"
            compiler = [swiftc, "-target", target, "-module-cache-path", str(temp / "modules")]
            result = run([*compiler, "-parse-as-library", "-emit-library", str(swift_file), "-o", str(library)])
            result["passed"] = result["status"] == 0 and library.is_file() and library.stat().st_size > 0
            record = {"sha": case[revision + "_sha"], "build": result}
            if case_id in calls and result["passed"]:
                main = temp / "main.swift"
                main.write_text(calls[case_id] + "\n")
                executable = temp / "fixture"
                build = run([*compiler, str(swift_file), str(main), "-o", str(executable)])
                record["harness_build"] = build
                if build["status"] == 0 and executable.is_file():
                    record["behavior"] = run([str(executable)])
            revision_checks[revision] = record

    checked = {"case_id": case_id, **revision_checks}
    if case_id in calls:
        before = revision_checks["before"].get("behavior")
        after = revision_checks["after"].get("behavior")
        checked["behavior_passed"] = bool(
            before and after and before["status"] == after["status"] == 0
            and before["stdout"] == after["stdout"]
            and (case_id not in expected_logs or before["stdout"].strip() == expected_logs[case_id])
        )
        checked["harness"] = calls[case_id]
    return checked


with ThreadPoolExecutor(max_workers=4) as pool:
    checked = list(pool.map(check_case, cases))
assert len(checked) == 40 and sum("behavior_passed" in c for c in checked) == 6
result = {
    "swift_version": swift_version,
    "target": target,
    "builds_passed": sum(c[r]["build"]["passed"] for c in checked for r in ("before", "after")),
    "behavior_pairs_passed": sum(c.get("behavior_passed", False) for c in checked),
    "cases": checked,
}
# Avoid embedding machine-specific temporary paths in compiler messages.
report = re.sub(r"/(?:private/)?(?:var/folders/[^\s]+?/T|tmp)/tmp[^/\s]+/", "", json.dumps(result, indent=2))
destination.write_text(report + "\n")
print(f'{result["builds_passed"]}/80 compiled, {result["behavior_pairs_passed"]}/6 behavior pairs passed')
