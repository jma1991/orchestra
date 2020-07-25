#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scater)

    sce <- readRDS(input$rds)

    fct <- librarySizeFactors(sce)

    dat <- data.frame(cellName = colnames(sce), sizeFactor = fct)

    write.csv(dat, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output)