#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    dec <- readRDS(input$rds)

    fit <- metadata(dec)

    pdf(output$pdf)

    plot(dec$mean, dec$total, pch = 19, log = "xy", xlab = "Mean of log-expression", ylab = "CV2 of log-expression")
    
    curve(fit$trend(x), add = TRUE, col = "red", lwd = 2)

    dev.off()

}

main(snakemake@input, snakemake@output)