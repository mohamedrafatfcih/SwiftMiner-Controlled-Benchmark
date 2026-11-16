# SwiftMiner controlled benchmark

The benchmark contains 40 independent before/after Swift revision pairs covering ten catalog types. Each type has three positives and a similar-looking negative control. The examples were constructed for controlled evaluation during development.

## Inspect the cases

Start with the [case index](CASE_INDEX.md) and [answer key with current validation status](oracle.json). Each case branch contains an after commit whose sole parent is the before commit. The cases directory holds the same source snapshots for convenient browsing. The evaluated case commits and expected answers are unchanged. The [original answer key at the benchmark freeze](https://github.com/mohamedrafatfcih/SwiftMiner-Controlled-Benchmark/blob/04211fd384db481b02837e83c9353eb286211b61/oracle.json) preserves the construction-time metadata.

## Check the evidence

- [Original SwiftMiner pilot](evidence/original-pilot/metrics.json) completed all 40 cases and reported 27 true positives, 0 false positives, and 3 false negatives. The original output and scoring records are linked in the same directory. SwiftMiner scoring checks the type and relevant code entities.
- [Fixture checks](evidence/fixture-results.json) record independent compilation and selected R7/R8 executable behavior checks, performed after the pilot.
- [Git line-diff results](evidence/git-baseline-results.json) record which edit hunks flagged corresponding spans on the same 40 pairs. See [paired cases](evidence/paired-cases.csv) and [intervals](evidence/confidence-intervals.json). The Git rule measures line-level correspondence.
- **Author re-annotation.** The author re-labeled all 40 shuffled pairs about one day after last seeing the original labels. Before reconciliation, 37 of 40 labels agreed (92.5%, Cohen’s κ = 0.916). The three disagreements were checked against the catalog conditions, and the frozen answer key was retained. Independent review remains future work.

From a clone, Python 3 and Git reproduce the text baseline:

    python3 evidence/git_baseline.py . git-baseline-results.json

On macOS with Swift installed, the following command compiles all snapshots and runs the selected behavior checks:

    python3 evidence/check_fixtures.py . fixture-results.json "$(xcrun --find swiftc)"

## Run SwiftMiner

With the evaluated SwiftMiner CLI available, run its local subcommand with the clone's file URL and the after commit from the answer key. Repeat the include-refactoring option for each of the ten type identifiers in the answer key and request JSON output. Run one case at a time and score the resulting records one-to-one by expected type and entity identity. Each positive case expects a single instance. Each negative control expects zero catalog instances.

The catalog was motivated by [Refactoring Swift: A Catalog of 10 Essential Practices for Code Improvement](https://doi.org/10.1002/smr.70180).
