#!/usr/bin/env Rscript

main <- function(input, output) {

    mat <- readRDS(input$rds)

    hvg <- readRDS(input$rds)
    
    cor <- correlatePairs(sce, subset.row = hvg)

    saveRDS(output$rds)

}

main(snakemake@input, snakemake@output)