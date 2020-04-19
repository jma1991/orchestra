#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("SingleCellExperiment")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds[1])

    dat <- readRDS(input$rds[2])

    sce <- sce[, !dat$discard]

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output)