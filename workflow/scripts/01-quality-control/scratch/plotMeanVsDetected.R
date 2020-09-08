#!/usr/bin/env Rscript

main <- function(input, output) {

    library(ggplot2)

    library(scales)

    dat <- read.csv(input$csv)

    plt <- ggplot(dat, aes(mean, detected)) + 
        geom_point(colour = "#BAB0AC") + 
        geom_smooth(color = "#E15759") + 
        scale_x_log10(labels = comma) + 
        labs(x = "Mean", y = "Detected") + 
        theme_classic()

    ggsave(output$pdf, plot = plt, width = 4, height = 3, scale = 0.8)

}

main(snakemake@input, snakemake@output)