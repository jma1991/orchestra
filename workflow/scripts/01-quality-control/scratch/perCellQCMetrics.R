#!/usr/bin/env Rscript

main <- function(input, output, params) {

    library(scater)

    sce <- readRDS(input$rds)

    sub <- as.list(rowData(sce)[, params$sub, drop = FALSE])

    out <- perCellQCMetrics(sce, subsets = sub)
    
    write.csv(out, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output, snakemake@params)