#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("SingleCellExperiment")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds)

    idx <- seq_len(params$num)

    dim <- dim[, idx]

    saveRDS(dim, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params)