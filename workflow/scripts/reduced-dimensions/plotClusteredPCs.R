#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    dat <- read.csv(input$csv, row.names = 1)
    
    num <- readLines(input$txt)

    plt <- ggplot(dat, aes(n.pcs, n.clusters)) + 
        geom_point(colour = "#79706E") + 
        geom_abline(intercept = 1, slope = 1, colour = "#E15759") + 
        geom_vline(xintercept = as.numeric(num), colour = "#79706E", linetype = "dashed") + 
        labs(x = "Number of PCs", y = "Number of clusters") + 
        theme_bw()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)