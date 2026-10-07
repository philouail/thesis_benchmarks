# Benchmarks

These are the benchmarks that belong to the thesis alone. The benchmarks
published with the *Chromatograms* package (scalability against xcms, lazy
evaluation, interoperable extraction with `chromExtract`) are not duplicated
here: they live in the package itself, under `inst/benchmarks` of
[Chromatograms](https://github.com/rformassspectrometry/Chromatograms). Each
document below is executable with Quarto and records the session information of
the machine it ran on.

- `microbenchmark_storage_layout.qmd`: storage-layout microbenchmark for
  *Chromatograms* (list of `data.frame`s against matrices and `data.table`s);
  rendered to `microbenchmark_storage_layout.html` with the complete timing tables.
- `serialization_roundtrip.qmd`: write time, read time, on-disk size and round-trip
  fidelity of `saveRDS`, `qs2` and `alabaster` on real `Spectra` from MetaboLights
  MTBLS8735; writes its tables, session information and figure to `results/`.
- `results/`: outputs of `serialization_roundtrip.qmd` (`serialization_cost.csv`,
  `serialization_fidelity.csv`, `serialization_sessionInfo.txt`,
  `serialization_cost.png`).
