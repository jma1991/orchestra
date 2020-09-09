#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    dat <- read.csv(input$csv)

    plt <- ggplot(dat, aes(mean)) + 
        geom_histogram(colour = "#000000", fill = "#BAB0AC") + 
        scale_x_log10() + 
        labs(x = "Mean", y = "Count") + 
        theme_classic()

    ggsave(output$pdf, plot = plt, width = 4, height = 3, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)