#!/usr/bin/env Rscript
## ===========================================================================
## Background (Ch2) figure: the two orthogonal views of LC-MS data.
## A single LC-MS injection is a 3-D surface (retention time x m/z x intensity).
## A *chromatogram* is a horizontal slice at fixed m/z (intensity over time);
## a *spectrum* is a vertical slice at fixed retention time (intensity over m/z).
## Illustrative synthetic data; no download required.
## Output: thesis/graphics/spectrum_vs_chromatogram.png
## ===========================================================================
set.seed(1)
out <- "thesis/graphics/spectrum_vs_chromatogram.png"
png(out, width = 2400, height = 1050, res = 240)
par(mfrow = c(1, 2), mar = c(4.2, 4.2, 3, 1), cex.lab = 1.05, cex.main = 1.15)

## --- (a) chromatogram: intensity over retention time at a fixed m/z ---------
rt <- seq(0, 12, length.out = 800)
gauss <- function(x, mu, s, a) a * exp(-(x - mu)^2 / (2 * s^2))
eic <- gauss(rt, 4.1, 0.13, 1) + gauss(rt, 6.7, 0.18, 0.62) +
       gauss(rt, 8.9, 0.15, 0.40) + rnorm(length(rt), 0, 0.01)
eic[eic < 0] <- 0
plot(rt, eic, type = "l", lwd = 2, col = "#1B9E77",
     xlab = "retention time (min)", ylab = "intensity",
     main = "(a) chromatogram: fixed m/z", yaxt = "n")
abline(v = 4.1, lty = 3, col = "grey50")
text(4.1, 1.02, "spectrum taken here", pos = 4, cex = 0.8, col = "grey30")

## --- (b) spectrum: intensity over m/z at a fixed retention time -------------
mz  <- c(174.06, 175.06, 188.07, 245.11, 246.11, 301.14, 319.15, 320.15, 447.20)
int <- c(1.00,   0.14,   0.22,   0.61,   0.10,   0.33,   0.48,   0.09,   0.18)
plot(NA, xlim = c(150, 470), ylim = c(0, 1.08),
     xlab = "m/z", ylab = "intensity",
     main = "(b) spectrum: fixed retention time", yaxt = "n")
segments(mz, 0, mz, int, lwd = 2.2, col = "#7570B3")
points(mz, int, pch = 20, cex = 0.6, col = "#7570B3")
text(174.06, 1.00, "174.06", pos = 3, cex = 0.72, col = "grey30", offset = 0.25)
dev.off()
message("Wrote ", out)
