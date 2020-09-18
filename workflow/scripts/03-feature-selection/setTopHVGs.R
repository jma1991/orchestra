#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scran)

    sce <- readRDS(input$rds)

    hvg <- readLines(input$txt)

    metadata(sce)$var.features <- hvg

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output)