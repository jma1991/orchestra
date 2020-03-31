#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("ggplot2")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)

    pdf(output$pdf)

    par(mfrow = c(2, 2))

    boxplot(dat$sum, main = "Sum")

    boxplot(dat$detected, main = "Detected")

    dev.off()

}

main(snakemake@input, snakemake@output)