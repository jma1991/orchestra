#!/usr/bin/env Rscript

main <- function(input, output, params) {

    library(scran)

    sce <- readRDS(input$rds)

    dec <- modelGeneCV2WithSpikes(sce, spikes = params$alt)

    alt <- altExp(sce, params$alt)

    dec$isSpike <- rownames(dec) %in% rownames(alt)

    write.csv(dec, file = output$csv, quote = FALSE)

}

main(snakemake@input, snakemake@output, snakemake@params)