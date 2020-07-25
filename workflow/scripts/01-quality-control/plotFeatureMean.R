#!/usr/bin/env Rscript

main <- function(input, output) {

    library(ggplot2)

    dat <- read.csv(input$csv, row.names = 1)

    plt <- ggplot(dat, aes(mean)) + geom_histogram(colour = "#000000", fill = "#7F7F7F") + scale_x_log10()

    ggsave(output$pdf, plot = plt, width = 5, height = 5)

}

main(snakemake@input, snakemake@output)