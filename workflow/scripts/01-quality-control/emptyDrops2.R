#!/usr/bin/env Rscript

main <- function(input, output, log) {
    
    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    library(ggplot2)

    dat <- read.csv(input$csv)

    dat <- subset(dat, !is.na(FDR))

    dat$Status <- ifelse(dat$FDR < 0.05, "Full", "Empty")

    plt <- ggplot(dat, aes(Total, -LogProb, colour = Status)) + 
        geom_point(show.legend = FALSE) + 
        scale_colour_manual(values = c("Full" = "#59A14F", "Empty" = "#E15759")) + 
        scale_x_log10() + 
        scale_y_log10() + 
        labs(x = "Total", y = "-LogProb") + 
        theme_classic()

    ggsave(output$pdf, plot = plt, width = 4, height = 3, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)