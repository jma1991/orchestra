#!/usr/bin/env Rscript

main <- function(input, output, log) {
    
    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    library(ggplot2)

    dat <- read.csv(input$csv)
    
    dat <- subset(dat, !duplicated(rank))

    plt <- ggplot(dat, aes(rank, total)) + 
        geom_point(colour = "#BAB0AC") + 
        scale_x_log10() + 
        scale_y_log10() + 
        labs(x = "Rank", y = "Total") + 
        theme_classic()

    ggsave(output$pdf, plot = plt, width = 4, height = 3, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)