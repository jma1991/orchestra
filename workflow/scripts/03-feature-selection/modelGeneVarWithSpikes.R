#!/usr/bin/env Rscript

main <- function(input, output, params) {

    library(scran)

    sce <- readRDS(input$rds)

    dec <- modelGeneVarWithSpikes(sce, spikes = params$alt)

    dec$spike <- FALSE

    alt <- metadata(dec)

    fit <- data.frame(mean = alt$mean, total = alt$var, tech = NA, bio = NA, p.value = NA, FDR = NA, spike = TRUE)

    dec <- rbind(dec, fit)

    write.csv(dec, file = output$csv, quote = FALSE)

}

main(snakemake@input, snakemake@output, snakemake@params)