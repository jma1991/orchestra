#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    res <- findMarkers(sce, sce$cluster, test.type = params$test)






}

main(snakemake@input, snakemake@output)