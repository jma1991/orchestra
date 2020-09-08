#!/usr/bin/env Rscript

main <- function(input, output, log) {

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    library(ggplot2)

    dat <- read.csv(input$csv)

    dat <- subset(dat, Total <= 100 & Total > 0)

    plt <- ggplot(dat, aes(PValue)) + 
        geom_histogram(bins = 50, colour = "#000000", fill = "#BAB0AC") + 
        labs(x = "P-value", y = "Frequency") + 
        theme_classic()

    ggsave(output$pdf, plot = plt, width = 4, height = 3, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)