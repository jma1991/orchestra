#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    dat <- perCellQCMetrics(sce)

    saveRDS(dat, output$rds)

}

main(snakemake@input, snakemake@output)