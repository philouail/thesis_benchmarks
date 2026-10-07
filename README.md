# Thesis benchmarks and figure sources

Benchmarks and figure sources of the doctoral thesis *From Files to Repositories: An
Interoperable Open-Source Ecosystem for Reproducible Metabolomics by Liquid
Chromatography–Mass Spectrometry and Its Application to Public-Data Reanalysis*
(Philippine Louail, Friedrich-Schiller-Universität Jena). The thesis text itself is
published by the university library after the defence.

## Benchmarks

Executable [Quarto](https://quarto.org) documents, each with its rendered HTML and the
session information of the machine it ran on (see [`benchmarks/README.md`](benchmarks/README.md)).

| Document | What it measures | Thesis section |
|---|---|---|
| `benchmarks/microbenchmark_storage_layout.qmd` | Storage layout of chromatographic peaks data in *Chromatograms*: a list of `data.frame`s against matrices and `data.table`s | Chapter 4 |
| `benchmarks/serialization_roundtrip.qmd` | Write time, read time, file size and round-trip fidelity of `saveRDS`, `qs2` and Alabaster on `Spectra` objects from MetaboLights MTBLS8735; outputs in `benchmarks/results/` | Chapter 5 |

The benchmarks published with the *Chromatograms* package (scalability against `xcms`,
lazy evaluation, `chromExtract()`) are part of that package, under `inst/benchmarks` of
[rformassspectrometry/Chromatograms](https://github.com/rformassspectrometry/Chromatograms).

## Figure sources

| Path | Content |
|---|---|
| `figure_sources/diagrams/` | PlantUML sources of the diagrams in Chapters 3, 4 and 5 |
| `figure_sources/scripts/` | R scripts that draw the Chapter 2 figure (spectrum against chromatogram) and the Chapter 6 quality-control figure |

Render a diagram with [PlantUML](https://plantuml.com):

```bash
java -DPLANTUML_LIMIT_SIZE=16384 -jar plantuml.jar -tpng -Sdpi=300 figure_sources/diagrams/<name>.puml
```

The R scripts write their figure to `thesis/graphics/` of the thesis source; change the
output path at the top of each script to render elsewhere.

## Related repositories

The software and analyses behind the thesis are listed in its Chapter 9, among them
[philouail/reverse-met](https://github.com/philouail/reverse-met) (Chapter 7) and
[philouail/HUMAN_Ring_Trial](https://github.com/philouail/HUMAN_Ring_Trial) (Chapter 5).
