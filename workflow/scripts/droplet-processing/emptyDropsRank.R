#!/usr/bin/env Rscript

breaks_log10 <- function(x) {

    # Return breaks for log10 axes

    10^seq(0, ceiling(log10(max(x))))

}

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

    use <- which(dat$FDR < params$FDR)

    dat$Status <- "Empty"

    dat$Status[use] <- "Cell"

    tab <- table(dat$Status)

    lab <- list(
        "Cell" = sprintf("Cell (%s)", comma(tab["Cell"])),
        "Empty" = sprintf("Empty (%s)", comma(tab["Empty"]))
    )

    val <- list(
        "Cell" = "#59A14F", 
        "Empty" = "#E15759"
    )

    dat$Rank <- rank(-dat$Total)

    dat <- subset(dat, !duplicated(Rank))

    dat <- as.data.frame(dat)

    plt <- ggplot(dat, aes(Rank, Total, colour = Status)) + 
        geom_point(shape = 1, show.legend = TRUE) + 
        scale_colour_manual(name = "Droplet", labels = lab, values = val) + 
        scale_x_log10(name = "Barcode Rank", breaks = breaks_log10, labels = label_number_si()) + 
        scale_y_log10(name = "Total Count", breaks = breaks_log10, labels = label_number_si()) + 
        theme_bw() + 
        theme(
            axis.title.x = element_text(margin = unit(c(1, 0, 0, 0), "lines")), 
            axis.title.y = element_text(margin = unit(c(0, 1, 0, 0), "lines")), 
            legend.justification = "top"
        )

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

    # Image function

    library(magick)

    pdf <- image_read_pdf(output$pdf)
    
    pdf <- image_trim(pdf)

    pdf <- image_border(pdf, color = "#FFFFFF", geometry = "50x50")
    
    pdf <- image_write(pdf, path = output$pdf, format = "pdf")

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)