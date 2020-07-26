#!/usr/bin/env Rscript

main <- function(input, output) {

    library(ggplot2)

    dec <- read.csv(input$csv, row.names = 1)

    plt <- ggplot(dec, aes(mean, total)) + 
        geom_point(colour = "#A2A2A2") + 
        geom_line(aes(y = tech), colour = "#ED665D") + 
        labs(x = "Mean normalized log-expression", y = "Variance of the normalized log-expression")
    
    ggsave(output$pdf, plot = plt, width = 4, height = 4)

}

main(snakemake@input, snakemake@output)