#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)

    sub <- paste("subsets", params$sub, "percent", sep = "_")

    alt <- paste("altexps", params$alt, "percent", sep = "_")

    pct <- c(sub, alt)

    fit <- quickPerCellQC(dat, percent_subsets = pct)

    saveRDS(fit, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params)