#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("SingleCellExperiment")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds[1])

    dec <- readRDS(input$rds[2])

    hvg <- readRDS(input$rds[3])

    lgl <- rownames(sce) %in% hvg

    rowData(sce)$Highly_Variable <- lgl

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output)