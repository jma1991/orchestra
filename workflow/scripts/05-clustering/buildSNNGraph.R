#!/usr/bin/env Rscript

main <- function(input, output, wildcards) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds)

    knn <- as.numeric(wildcards$knn)

    snn <- as.character(wildcards$snn)
    
    snn <- buildSNNGraph(dim, k = knn, d = NA, type = snn, transposed = TRUE)

    saveRDS(snn, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@wildcards)