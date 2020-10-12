#!/usr/bin/env Rscript

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    sce <- readRDS(input$rds)

    sce <- computeSpikeFactors(sce, spikes = params$alt)

    fct <- sizeFactors(sce)

    saveRDS(fct, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)