#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scran)

    sce <- readRDS(input$rds)

    dec <- modelGeneCV2(sce)

    write.csv(dec, file = output$csv, quote = FALSE)

}

main(snakemake@input, snakemake@output)