#!/usr/bin/env Rscript

main <- function(input, output, wildcards) {

    library(ggplot2)

    dat <- read.csv(input$csv)

    plt <- ggplot(dat, aes_string(wildcards$x, wildcards$y)) + 
        geom_point(colour = "#BAB0AC") + 
        labs(x = wildcards$x, y = wildcards$y) + 
        theme_classic()

    ggsave(output$pdf, plot = plt, width = 4, height = 3, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@wildcards)