#!/usr/bin/env Rscript

main <- function(input, output, params) {

    library(ggplot2)

    dec <- read.csv(input$csv, row.names = 1)

    fit <- subset(dec, isTRUE(isSpike))

    plt <- ggplot(dec, aes(mean, total)) + 
        geom_point(colour = "#A2A2A2") + 
        geom_line(aes(mean, trend), colour = "#ED665D") + 
        geom_point(data = fit, aes(mean, cv2), colour = "#ED665D") + 
        labs(x = "Mean of log-expression", y = "Variance of log-expression")

    ggsave(output$pdf, plot = plt, width = 4, height = 4)
}

main(snakemake@input, snakemake@output, snakemake@params)