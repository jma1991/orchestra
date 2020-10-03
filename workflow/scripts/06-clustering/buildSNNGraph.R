#!/usr/bin/env Rscript

main <- function(input, output, log, wildcards) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    dim <- readRDS(input$rds)

    knn <- as.numeric(wildcards$knn)

    snn <- as.character(wildcards$snn)
    
    snn <- buildSNNGraph(dim, k = knn, d = NA, type = snn, transposed = TRUE)

    saveRDS(snn, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@wildcards)