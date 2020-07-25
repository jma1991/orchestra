#!/usr/bin/env Rscript

main <- function(input, output, params) {

    library(scran)

    sce <- readRDS(input$rds)

    sce <- computeSpikeFactors(sce, spikes = params$alt)

    fct <- sizeFactors(sce)

    dat <- data.frame(cellName = colnames(sce), sizeFactor = fct)

    write.csv(dat, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output, snakemake@params)