#!/usr/bin/env Rscript
## ===========================================================================
## Regenerate the quality-control figure for Chapter 6 (fig:meta-qc):
## the base-peak chromatogram (BPC) of every sample in the Metabonaut plasma
## example (MetaboLights MTBLS8735), coloured by study group.
##
## Data are fetched from MetaboLights on first run and cached locally by
## MsBackendMetaboLights, so an internet connection is needed once. The BPC is
## read from the mzML base-peak-intensity header (falling back to computing it
## from the peak data), which avoids materialising the full profile data.
##
## Run from the repository root:
##   Rscript analysis/figures/metabonaut_qc.R
## Output:
##   thesis/graphics/metabonaut_qc_example.png
## ===========================================================================

suppressPackageStartupMessages({
  library(Spectra)
  library(MsBackendMetaboLights)
  library(RColorBrewer)
})

## --- load the MTBLS8735 plasma example directly from MetaboLights ----------
sps <- Spectra(
  source      = MsBackendMetaboLights(),
  mtblsId     = "MTBLS8735",
  assayName   = paste0("a_MTBLS8735_LC-MS_positive_",
                       "hilic_metabolite_profiling.txt"),
  filePattern = ".mzML")
sps <- filterMsLevel(sps, 1L)          # MS1 for the survey BPC

rt  <- rtime(sps) / 60                  # minutes
org <- basename(dataOrigin(sps))        # one mzML file per sample

## base-peak intensity: prefer the mzML header value, else compute from peaks
bpi <- tryCatch(sps$basePeakIntensity, error = function(e) NULL)
if (is.null(bpi) || all(is.na(bpi)))
  bpi <- vapply(intensity(sps), function(x) if (length(x)) max(x) else 0,
                numeric(1))

## --- map each sample file to its study group (from the ISA-Tab design) ------
## Samples A-F are experimental (3 CVD cases, 3 controls); POOL are QC pools.
key    <- c(A = "CVD", B = "CTR", C = "CTR", D = "CVD", E = "CTR", F = "CVD")
letter <- toupper(sub(".*_MS_([A-Fa-f])_POS.*", "\\1", org))
pheno  <- ifelse(grepl("POOL", org, ignore.case = TRUE), "QC",
                 unname(key[letter]))

groups <- c("QC", sort(setdiff(unique(pheno), "QC")))
col_ph <- setNames(brewer.pal(9, "Set1")[c(9, 5, 4)][seq_along(groups)], groups)

## --- base-peak chromatogram of every sample, coloured by group -------------
out <- file.path("thesis", "graphics", "metabonaut_qc_example.png")
png(out, width = 2200, height = 1150, res = 220)
plot(NA, xlim = range(rt, na.rm = TRUE), ylim = c(0, max(bpi, na.rm = TRUE)),
     xlab = "retention time (min)", ylab = "base-peak intensity",
     main = "Base-peak chromatograms, MTBLS8735 (coloured by group)")
for (f in unique(org)) {
  i <- which(org == f); i <- i[order(rt[i])]
  lines(rt[i], bpi[i], col = paste0(col_ph[pheno[i][1]], "80"), lwd = 1.2)
}
grid()
legend("topright", col = col_ph, legend = names(col_ph),
       lty = 1, lwd = 2, horiz = TRUE, bty = "n")
dev.off()
message("Wrote ", normalizePath(out))
