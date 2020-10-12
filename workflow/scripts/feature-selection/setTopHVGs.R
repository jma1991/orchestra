#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scran)

    sce <- readRDS(input$rds[1])

    hvg <- readRDS(input$rds[2])

    metadata(sce)$HVG <- hvg

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output)