#!/usr/bin/env Rscript

main <- function(input, output) {

    dat <- readRDS(input$rds)

    pdf(output$pdf)

    plot(dat$sum, dat$detected, x = "sum", y = "detected")

    dev.off()

}

main(snakemake@input, snakemake@output)