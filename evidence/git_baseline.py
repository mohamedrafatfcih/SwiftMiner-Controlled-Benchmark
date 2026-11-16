import json
import re
import subprocess
import sys
from pathlib import Path


repo = Path(sys.argv[1])
cases = json.loads((repo / "oracle.json").read_text())["cases"]
fixture = "Sources/Fixture.swift"
hunk_header = re.compile(r"^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@", re.M)


def line_span(location):
    match = re.fullmatch(r"Sources/Fixture\.swift:(\d+)(?:-(\d+))?", location)
    assert match, location
    return int(match[1]), int(match[2] or match[1])


def overlaps(start, count, expected):
    return start <= expected[1] and start + count - 1 >= expected[0]


assert overlaps(3, 1, (1, 3)) and not overlaps(4, 1, (1, 3))
rows = []
for case in cases:
    diff = subprocess.check_output([
        "git", "-C", str(repo), "diff", "--no-ext-diff", "--no-textconv", "--no-color",
        "--no-indent-heuristic", "--diff-algorithm=myers", "--unified=0",
        case["before_sha"], case["after_sha"], "--", fixture,
    ], text=True)
    positive = bool(case["expected_instance_count"])
    matches = 0
    candidates = []
    for old_start, old_count, new_start, new_count in hunk_header.findall(diff):
        old_start, old_count, new_start, new_count = [int(x or 1) for x in (old_start, old_count, new_start, new_count)]
        if not old_count or not new_count:
            continue
        is_match = (
            positive and matches == 0
            and overlaps(old_start, old_count, line_span(case["locations"]["before"]))
            and overlaps(new_start, new_count, line_span(case["locations"]["after"]))
        )
        matches += int(is_match)
        candidates.append({"old": [old_start, old_count], "new": [new_start, new_count], "matched": is_match})
    rows.append({"case_id": case["case_id"], "candidates": candidates,
                 "tp": matches, "fp": len(candidates) - matches, "fn": int(positive) - matches})

totals = {key: sum(row[key] for row in rows) for key in ("tp", "fp", "fn")}
assert len(rows) == 40 and totals["tp"] + totals["fn"] == 30
assert totals["tp"] + totals["fp"] == sum(len(row["candidates"]) for row in rows)
result = {**totals, "git_version": subprocess.check_output(["git", "--version"], text=True).strip(), "cases": rows}
Path(sys.argv[2]).write_text(json.dumps(result, indent=2) + "\n")
print(totals)
