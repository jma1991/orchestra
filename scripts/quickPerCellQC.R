#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)

    out <- quickPerCellQC(dat)

    saveRDS(out, output$rds)

}

main(snakemake@input, snakemake@output)