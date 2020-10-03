#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    dec <- read.csv(input$csv, row.names = 1)

    plt <- ggplot(dec, aes(mean, total)) + 
        geom_point(colour = "#BAB0AC") + 
        geom_line(aes(y = tech), colour = "#E15759") + 
        labs(x = "Mean of log-expression", 
             y = "Variance of log-expression") + 
        theme_bw()
    
    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)