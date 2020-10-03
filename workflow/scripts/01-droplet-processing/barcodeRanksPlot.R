#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function
    
    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    bcr <- readRDS(input$rds)
    
    bcr <- subset(bcr, !duplicated(rank))

    plt <- ggplot(as.data.frame(bcr), aes(rank, total)) + 
        geom_point(colour = "#767676") + 
        geom_hline(yintercept = metadata(bcr)$inflection, colour = "#4E79A7", linetype = "dashed") + 
        geom_hline(yintercept = metadata(bcr)$knee, colour = "#59A14F", linetype = "dashed") + 
        annotate("text", x = 1, y = metadata(bcr)$inflection, label = "Inflection", hjust = 0, vjust = -1) + 
        annotate("text", x = 1, y = metadata(bcr)$knee, label = "Knee", hjust = 0, vjust = -1) +
        scale_x_log10() + 
        scale_y_log10() + 
        labs(x = "Rank", y = "Total") + 
        theme_classic()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)