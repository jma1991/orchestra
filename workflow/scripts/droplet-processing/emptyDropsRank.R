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

    dat <- readRDS(input$rds)

    dat <- as.data.frame(dat)

    dat$Rank <- rank(-dat$Total)

    ix1 <- which(dat$Total > params$lower)

    ix2 <- which(dat$FDR < params$FDR)

    use <- intersect(ix1, ix2)

    dat$Status <- "Empty"

    dat$Status[use] <- "Cell"

    dat <- subset(dat, !is.na(FDR))
    
    dat <- subset(dat, !duplicated(Rank))

    plt <- ggplot(dat, aes(Rank, Total, colour = Status)) + 
        geom_point(shape = 1) + 
        scale_colour_manual(values = c("Cell" = "#4E79A7", "Empty" = "#E15759")) + 
        scale_x_log10(name = "Barcode Rank", breaks = breaks_log(10), labels = label_number_si()) +
        scale_y_log10(name = "Total Count", breaks = breaks_log(10), labels = label_number_si()) +
        theme_bw() + 
        theme(legend.justification = "top")

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)


    # Image function

    library(magick)

    pdf <- image_read_pdf(output$pdf)
    
    pdf <- image_trim(pdf)

    pdf <- image_border(pdf, color = "#FFFFFF", geometry = "50x50")
    
    pdf <- image_write(pdf, path = output$pdf, format = "pdf")


}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)