#!/usr/bin/env Rscript

main <- function(input, output) {

    library(scater)

    sce <- readRDS(input$rds)

    plt <- plotHighestExprs(sce)

    ggsave(output$pdf, plot = plt, width = 5, height = 5)

}

main(snakemake@input, snakemake@output)