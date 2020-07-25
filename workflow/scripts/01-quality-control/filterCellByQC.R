#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scater)

    sce <- readRDS(input$rds)

    dat <- read.csv(input$csv, row.names = 1)

    sce <- sce[, !dat$discard]

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output)