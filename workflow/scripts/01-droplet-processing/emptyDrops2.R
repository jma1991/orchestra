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

    dat <- subset(dat, !is.na(FDR))

    dat$Status <- ifelse(dat$FDR < 0.05, "Full", "Empty")

    plt <- ggplot(dat, aes(Total, -LogProb, colour = Status)) + 
        geom_point(show.legend = FALSE) + 
        scale_colour_manual(values = c("Full" = "#4E79A7", "Empty" = "#BAB0AC")) + 
        labs(x = "Total", y = "-log(Probability)") + 
        theme_classic()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)