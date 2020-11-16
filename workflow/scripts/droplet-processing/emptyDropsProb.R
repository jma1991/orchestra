#!/usr/bin/env Rscript

replace.ambient <- function(x) {

    # Replace results for barcodes with totals less than or equal to lower

    i <- x$Total <= metadata(x)$lower

    x$LogProb[i] <- NA

    x$PValue[i] <- NA

    x$Limited[i] <- NA

    x$FDR[i] <- NA

    p <- x$PValue
    
    i <- x$Total >= metadata(x)$retain

    p[i] <- 0

    x$FDR <- p.adjust(p, method = "BH")

    return(x)

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

    dat <- replace.ambient(dat)

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
        scale_colour_manual(values = col, labels = lab) + 
        scale_x_continuous(name = "Total Count", breaks = breaks_pretty(), labels = label_number_si()) + 
        scale_y_continuous(name = "-log(P-value)", breaks = breaks_pretty(), labels = label_comma()) + 
        ggtitle("Barcode Probability Plot") + 
        theme_bw() + 
        theme(legend.title = element_blank(), legend.justification = "top")

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)


    # Image function

    library(magick)

    pdf <- image_read_pdf(output$pdf)
    
    pdf <- image_trim(pdf)

    pdf <- image_border(pdf, color = "#FFFFFF", geometry = "50x50")
    
    pdf <- image_write(pdf, path = output$pdf, format = "pdf")

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)