#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("SingleCellExperiment")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds[1])

    hvg <- readRDS(input$rds[2])

    lgl <- rownames(sce) %in% hvg

    rowData(sce)$variable <- lgl

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params)