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
    
    dat <- subset(dat, !duplicated(rank))

    plt <- ggplot(dat, aes(rank, total)) + 
        geom_point(colour = "#BAB0AC") + 
        scale_x_log10() + 
        scale_y_log10() + 
        labs(x = "Rank", y = "Total") + 
        theme_bw()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)