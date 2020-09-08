#!/usr/bin/env Rscript

binwidth <- function(x) {

    breaks <- pretty(range(x), n = nclass.scott(x), min.n = 1)
    
    width <- breaks[2] - breaks[1]

}

main <- function(input, output) {

    library(ggplot2)

    library(scales)

    dat <- read.csv(input$csv)

    bin <- binwidth(dat$mean)

    plt <- ggplot(dat, aes(mean)) + 
        geom_histogram(binwidth = binwidth, colour = "#000000", fill = "#BAB0AC") + 
        scale_x_log10(labels = comma) + 
        labs(x = "Mean", y = "Count") + 
        theme_classic()

    ggsave(output$pdf, plot = plt, width = 4, height = 3, scale = 0.8)

}

main(snakemake@input, snakemake@output)