#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(intrinsicDimension)

    dim <- read.csv(input$csv, row.names = 1)

    est <- maxLikGlobalDimEst(dim, k = 15)

}

main(snakemake@input, snakemake@output, snakemake@log)