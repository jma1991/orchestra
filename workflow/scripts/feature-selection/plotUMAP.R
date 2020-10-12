#!/usr/bin/env Rscript

main <- function(input, output, log, wildcards) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    dat <- read.csv(input$csv, row.names = 1)

    plt <- ggplot(dat, aes_string("V1", "V2")) + 
        geom_point() + 
        labs(x = "UMAP 1", y = "UMAP 2") + 
        coord_fixed() + 
        theme_bw() + 
        theme(aspect.ratio = 1)

    ggsave(file = output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log, snakemake@wildcards)