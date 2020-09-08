#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scater)

    sce <- readRDS(input$rds)

    out <- perFeatureQCMetrics(sce)

    write.csv(out, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output)