#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    dec <- readRDS(input$rds)

    fit <- metadata(dec)

    pdf(output$pdf)

    plot(dec$mean, dec$total, pch = 19, log = "xy", xlab = "Mean of log-expression", ylab = "CV2 of log-expression")

    points(fit$mean, fit$cv2, pch = 19, col = "red")

    curve(fit$trend(x), add = TRUE, col = "red")

    legend("topright", legend = params$alt, col = "red", pch = 19)

    dev.off()

}

main(snakemake@input, snakemake@output, snakemake@params)