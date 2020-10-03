#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    dim <- reducedDim(sce, "PCA")

    mat <- dist(dim)

    hcl <- hclust(mat)

    saveRDS(mat, output$rds[1])

    saveRDS(hcl, output$rds[2])

}

main(snakemake@input, snakemake@output)