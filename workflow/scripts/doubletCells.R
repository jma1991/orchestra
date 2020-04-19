#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scater", "scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    dim <- reducedDim(sce, "PCA")

    num <- ncol(dim)

    dbl <- doubletCells(sce, d = num)

    sce$doubletCells <- log10(dbl + 1)

    saveRDS(sce, output$rds)

}

main(snakemake@input, snakemake@output)