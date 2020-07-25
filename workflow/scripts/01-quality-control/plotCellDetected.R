#!/usr/bin/env Rscript

main <- function(input, output) {

    library(ggplot2)

    dat <- read.csv(input$csv, row.names = 1)

    plt <- ggplot(dat, aes(detected)) + geom_histogram(fill = "#C7C7C7", colour = "#000000") + scale_x_log10()

    ggsave(output$pdf, plot = plt, width = 4, height = 4)

}

main(snakemake@input, snakemake@output)