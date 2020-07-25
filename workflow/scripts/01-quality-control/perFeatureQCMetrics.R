#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scater)

    sce <- readRDS(input$rds)

    met <- perFeatureQCMetrics(sce)

    write.csv(met, file = output$csv)

}

main(snakemake@input, snakemake@output)