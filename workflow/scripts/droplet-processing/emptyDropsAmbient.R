#!/usr/bin/env Rscript

main <- function(input, output, params, log, threads) {

    # Log function
    
    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(DropletUtils)

    sce <- readRDS(input$rds)

    set.seed(1701)

    out <- emptyDrops(counts(sce), lower = params$lower, niters = params$niters, test.ambient = TRUE)

    saveRDS(out, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log, snakemake@threads)
