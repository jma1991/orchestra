#!/usr/bin/env Rscript

main <- function(input, output, params, log) {

    # Log function
    
    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(DropletUtils)

    sce <- readRDS(input$rds)

    bcr <- barcodeRanks(counts(sce), lower = params$lower)

    metadata(bcr)$lower <- params$lower

    saveRDS(bcr, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)