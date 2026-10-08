# SwiftMiner controlled evaluation examples

40 independent revision pairs: three positives and one negative for each of ten Swift catalog types. All source examples are pure deterministic Swift; there is no package or external dependency. Each pair changes only Sources/Fixture.swift. Each case branch starts from the same scaffold, then has one before commit and one after commit. Main holds the frozen oracle and folder snapshots.

## Open in SwiftRefDetector

1. Choose a local repository and this repository folder.
2. Choose Commit / One Commit and paste the after_sha from oracle.json or CASE_INDEX.md. Its sole parent is the recorded before_sha.
3. Enable all ten Swift catalog types listed in oracle.json, using the same filters for every case. Run detection once per pair.
4. Export each result to a fresh runs/<run-id>/<case-id> path and record the app/detector revision and options. Review against the frozen expectation tuple. A negative must have zero detections across all ten types, not merely zero of its associated type.

Alternatively choose Compare Sources / Directories, selecting cases/<case-id>/before and cases/<case-id>/after. Select individual case folders; selecting the entire cases tree mixes examples. Do not analyze all branch history: it includes scaffold-to-before transitions outside the experiment.

## Expected results and review

oracle.json records all 40 pairs, domains, expected identities, source spans, checksums and commit hashes. Positive cases expect one catalog instance each; negatives have no expectation rows. R4-P3 changes two enum cases but expects one enum-level instance; R8-P3 moves two cleanup calls but expects one function-level instance.

Match by pair, catalog type and complete source/target identity, with parameter index for label changes. Match one-to-one; repeated emissions count as additional FP. Keep detections of conventional types outside catalog scoring. Keep execution failures separate from successful empty results. Record TP, FP, FN and negative-control detections; precision TP/(TP+FP), recall TP/(TP+FN), with undefined denominators reported as not estimable. Do not score failures as empty successful runs.

## Validity and limits

Examples were reviewed as source, not compiled or behavior-tested, as requested. sample() provides concrete inputs and inspectable outputs; it is not an executed test. R4 equivalence applies only to valid keys and payload types specified in the oracle. R7 equivalence applies to non-nil values avoiding overflow; nil after returns zero and would trap before. R8 sample() returns its log after visit exits so deferred events are observable; P2 covers both early and normal return domains. Negative controls may intentionally change behavior while withholding the catalog transformation.

R1-P3 and R3-P3 are nested-type stress cases. The detector may miss them; retain that result. R5-P2 has a second call-site comparison to review manually. These examples were constructed after inspection of detector code and development examples; report them as an author-designed controlled benchmark, not a held-out or independently validated corpus. Detector output has not been used to revise cases, and no detection run has been performed during construction.

The parent protocol documents describe an earlier package-and-tests plan. This repository follows the later user choice: detector app only, source review, no compilation or behavior tests. All results are pending.
