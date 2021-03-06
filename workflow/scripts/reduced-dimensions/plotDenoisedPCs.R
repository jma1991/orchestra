#!/usr/bin/env Rscript

set.seed(1701)

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(scales)

    dim <- readRDS(input$rds[1])

    num <- readRDS(input$rds[2])

    var <- attr(dim, "percentVar")

    dat <- data.frame(index = seq_along(var), total = cumsum(var))

    lab <- sprintf("PCs = %s", num)

    plt <- ggplot(dat, aes(index, total)) + 
        geom_point(colour = "#BAB0AC") + 
        geom_vline(xintercept = num, colour = "#E15759", linetype = "dashed") + 
        annotate("text", x = num, y = Inf, label = lab, angle = 90, vjust = -1, hjust = 1.1, colour = "#E15759") +
        scale_x_continuous(name = "Principal component", breaks = c(1, 10, 20, 30, 40, 50), labels = label_ordinal()) + 
        scale_y_continuous(name = "Cumulative variance", labels = label_percent(scale = 1)) + 
        theme_bw()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

    # Image function

    library(magick)

    pdf <- image_read_pdf(output$pdf)

    pdf <- image_trim(pdf)

    pdf <- image_border(pdf, color = "#FFFFFF", geometry = "50x50")

    pdf <- image_write(pdf, path = output$pdf, format = "pdf")

}

main(snakemake@input, snakemake@output, snakemake@log)