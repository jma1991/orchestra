#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scater", "scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    dbl <- doubletCluster(sce, sce$cluster)

    out <- isOutlier(dbl$N, type = "lower", log = TRUE)

    ids <- rownames(dbl)[out]

    sce$doubletCluster <- sce$cluster %in% ids

    saveRDS(sce, output$rds) 

}

main(snakemake@input, snakemake@output)