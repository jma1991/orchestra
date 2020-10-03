#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scater)

    sce <- readRDS(input$rds[1])

    fct <- readRDS(input$rds[2])

    sizeFactors(sce) <- fct

    sce <- logNormCounts(sce)

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)