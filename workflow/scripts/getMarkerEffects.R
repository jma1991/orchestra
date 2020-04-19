#!/usr/bin/env Rscript

main <- function(input, output, wildcards) {

    pkg <- c("scran", "pheatmap")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)
    
    res <- dat[[num]]

    sig <- subset(res, Top <= 10)
    
    lfc <- getMarkerEffects(sig)

    pheatmap(lfc, breaks = seq(-5, 5, length.out = 101), filename = output$pdf)

}

main(snakemake@input, snakemake@output, snakemake@wildcards)