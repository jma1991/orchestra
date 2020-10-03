#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    var <- readLines(input$txt[1])

    num <- readLines(input$txt[2])

    dat <- data.frame(component = seq_along(var), variance = as.numeric(var))

    plt <- ggplot(dat, aes(component, variance)) + 
        geom_point(colour = "#79706E") + 
        geom_vline(xintercept = as.numeric(num), colour = "#E15759") + 
        labs(x = "PC", y = "Varianced explained (%)") + 
        theme_bw()
    
    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)