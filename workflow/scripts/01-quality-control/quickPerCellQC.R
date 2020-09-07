#!/usr/bin/env Rscript

main <- function(input, output, params) {

    library(scater)

    dat <- read.csv(input$csv)

    idx <- intersect(colnames(dat), c(params$alt, params$sub))

    out <- quickPerCellQC(dat, percent_subsets = idx)

    write.csv(out, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output, snakemake@params)