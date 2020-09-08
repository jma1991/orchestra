#!/usr/bin/env Rscript

main <- function(input, output, log) {

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    library(ggplot2)

    dat <- read.csv(input$csv)

    dat$Rank <- rank(-dat$Total) # decreasing rank

    dat <- subset(dat, !is.na(FDR))
    
    dat <- subset(dat, !duplicated(Rank))

    dat$Status <- ifelse(dat$FDR < 0.05, "Full", "Empty")

    plt <- ggplot(dat, aes(Rank, Total, colour = Status)) + 
        geom_point(show.legend = FALSE) + 
        scale_colour_manual(values = c("Full" = "#4E79A7", "Empty" = "#BAB0AC")) + 
        scale_x_log10() + 
        scale_y_log10() + 
        labs(x = "Rank", y = "Total") + 
        theme_classic()

    ggsave(output$pdf, plot = plt, width = 4, height = 3, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)