#!/usr/bin/env Rscript

main <- function(input, output) {

    library(ggplot2)

    dec <- read.csv(input$csv, row.names = 1)

    plt <- ggplot(dec, aes(mean, total)) + 
        geom_point(colour = "#A2A2A2") + 
        geom_line(aes(y = trend), colour = "#ED665D") + 
        scale_x_log10() + scale_y_log10() + 
        labs(x = "Mean of log-expression", y = "Variance of log-expression")
    
    ggsave(output$pdf, plot = plt, width = 4, height = 4)

}

main(snakemake@input, snakemake@output)