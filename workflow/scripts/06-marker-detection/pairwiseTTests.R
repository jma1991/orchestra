#!/usr/bin/env Rscript

main <- function(input, output, wildcards) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    res <- pairwiseTTests(
        x = logcounts(sce),
        groups = sce$cluster,
        direction = wildcards$direction,
        lfc = as.numeric(wildcards$lfc)
    )

    saveRDS(res, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@wildcards)