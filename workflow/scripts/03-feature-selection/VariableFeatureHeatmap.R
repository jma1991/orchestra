#!/usr/bin/env Rscript

main <- function(input, output) {

    library(limma)

    library(scran)

    sce <- readRDS(input$rds)

    hvg <- readLines(input$txt)

    pdf(output$pdf)

    coolmap(x = logcounts(sce)[hvg, ], margins = c(9, 12), lhei = c(1, 5))

    dev.off()

}

main(snakemake@input, snakemake@output)