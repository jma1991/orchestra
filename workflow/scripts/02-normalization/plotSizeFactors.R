#!/usr/bin/env Rscript

main <- function(input, output) {

    library(ggplot2)

    dat <- read.csv(input$csv, row.names = "cellName")

    plt <- ggplot(dat, aes(sizeFactor)) + geom_histogram() + scale_x_log10()

    ggsave(output$pdf, plot = plt)

}

main(snakemake@input, snakemake@output)