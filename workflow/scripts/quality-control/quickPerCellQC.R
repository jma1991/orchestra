#!/usr/bin/env Rscript

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script functions

    library(scater)

    dat <- readRDS(input$rds)

    sub <- paste("subsets", params$sub, "percent", sep = "_")

    out <- quickPerCellQC(dat, percent_subsets = sub)

    saveRDS(out, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)