#!/usr/bin/env Rscript

main <- function(input, output, params) {

    library(SingleCellExperiment)

    sce <- readRDS(input$rds)

    dat <- read.csv(input$csv)

    use <- which(dat$FDR < params$FDR)

    sce <- sce[, use]

    saveRDS(sce, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params)