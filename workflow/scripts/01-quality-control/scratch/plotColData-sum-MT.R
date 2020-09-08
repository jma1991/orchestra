#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c()

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)

    pdf(output$pdf)

    plot(dat$sum, dat$subsets_MT_percent)

    dev.off()

}

main(snakemake@input, snakemake@output)