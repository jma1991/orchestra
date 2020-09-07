#!/usr/bin/env Rscript

main <- function(input, output) {

    library(DropletUtils)

    sce <- readRDS(input$rds)

    out <- barcodeRanks(counts(sce))

    write.csv(out, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output)