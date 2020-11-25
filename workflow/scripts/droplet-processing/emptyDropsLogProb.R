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
    
    use <- which(dat$FDR < params$FDR)
    
    dat$Status <- "Empty"
    
    dat$Status[use] <- "Cell"

    tab <- table(dat$Status)

    lab <- list(
        "Cell" = sprintf("Cell (%s)", comma(tab["Cell"])),
        "Empty" = sprintf("Empty (%s)", comma(tab["Empty"]))
    )

    col <- list(
        "Cell" = "#309143", 
        "Empty" = "#B60A1C"
    )

    plt <- ggplot(dat, aes(Total, -LogProb, colour = Status)) + 
        geom_point(shape = 1) + 
        scale_colour_manual(name = "Droplet", values = col, labels = lab) + 
        scale_x_continuous(name = "Total Count", breaks = breaks_pretty(), labels = label_number_si()) + 
        scale_y_continuous(name = "-log(Probability)", breaks = breaks_pretty(), labels = label_comma()) + 
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