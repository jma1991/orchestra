#!/usr/bin/env Rscript

main <- function(input, output) {

    library(ggplot2)

    library(scales)

    dat <- read.csv(input$csv, row.names = 1)

    plt <- ggplot(dat, aes(mean)) + 
        geom_histogram(bins = 100, colour = "#000000", fill = "#7F7F7F") + 
        scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x), labels = trans_format("log10", math_format(10^.x))) + 
        theme_classic() + 
        theme(axis.title.x = element_text(margin = unit(c(1, 0, 0, 0), "lines")),
              axis.title.y = element_text(margin = unit(c(0, 1, 0, 0), "lines")))

    ggsave(output$pdf, plot = plt, width = 5, height = 5)

}

main(snakemake@input, snakemake@output)