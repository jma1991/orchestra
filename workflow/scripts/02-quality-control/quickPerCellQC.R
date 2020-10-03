#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script functions

    library(scater)

    dat <- readRDS(input$rds)

    out <- quickPerCellQC(dat)

    saveRDS(out, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)