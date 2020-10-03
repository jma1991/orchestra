#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    dat <- readRDS(input$rds)

    dat <- as.data.frame(dat)

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

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)