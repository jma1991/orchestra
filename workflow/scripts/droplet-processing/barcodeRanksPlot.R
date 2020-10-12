#!/usr/bin/env Rscript

main <- function(input, output, params, log) {


    # Log function
    
    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")


    # Script function

    library(ggplot2)

    library(scales)

    bcr <- readRDS(input$rds)
    
    bcr <- subset(bcr, !duplicated(rank))

    dat <- as.data.frame(bcr)

    plt <- ggplot(dat, aes(rank, total)) + 
        geom_point(shape = 1, colour = "#000000") + 
        geom_hline(yintercept = metadata(bcr)$knee, colour = "#4E79A7", linetype = "dashed") + 
        geom_hline(yintercept = metadata(bcr)$inflection, colour = "#F28E2B", linetype = "dashed") + 
        geom_hline(yintercept = params$lower, colour = "#E15759", linetype = "dashed") + 
        annotate("text", x = 1, y = metadata(bcr)$knee, label = "Knee", colour = "#4E79A7", hjust = 0, vjust = -1) +
        annotate("text", x = 1, y = metadata(bcr)$inflection, label = "Inflection", colour = "#F28E2B", hjust = 0, vjust = -1) + 
        annotate("text", x = 1, y = params$lower, label = "Lower", colour = "#E15759", hjust = 0, vjust = -1) + 
        scale_x_log10(name = "Barcode Rank", breaks = breaks_log(10), labels = label_number_si()) + 
        scale_y_log10(name = "Total Count", breaks = breaks_log(10), labels = label_number_si()) + 
        theme_bw()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)


    # Image function

    library(magick)

    pdf <- image_read_pdf(output$pdf)
    
    pdf <- image_trim(pdf)

    pdf <- image_border(pdf, color = "#FFFFFF", geometry = "50x50")
    
    pdf <- image_write(pdf, path = output$pdf, format = "pdf")


}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)