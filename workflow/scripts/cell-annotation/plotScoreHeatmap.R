#!/usr/bin/env Rscript

main <- function(input, output, params, log) {
    
    # Log function
    
    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(SingleR)

    fit <- readRDS(input$rds)

    plotScoreHeatmap(fit, filename = output$pdf, width = 8, height = 6)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)