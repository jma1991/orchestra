#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scater)

    sce <- readRDS(input$rds)

    hvg <- rowData(sce)$HVG

    dim <- calculatePCA(sce, subset_row = hvg)

    write.csv(dim, file = output$csv, quote = FALSE)

    var <- attr(dim, "percentVar")

    writeLines(as.character(var), con = output$txt)

}

main(snakemake@input, snakemake@output)