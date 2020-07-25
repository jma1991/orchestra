#!/usr/bin/env Rscript

main <- function(input, output, params) {

    library(scater)

    dat <- read.csv(input$csv, row.names = 1)

    alt <- paste("altexps", params$alt, "percent", sep = "_")

    #sub <- paste("subsets", params$sub, "percent", sep = "_")

    fit <- quickPerCellQC(dat, percent_subsets = c(alt, sub))

    write.csv(fit, file = output$csv)

}

main(snakemake@input, snakemake@output, snakemake@params)