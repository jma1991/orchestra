#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(scales)

    df1 <- readRDS(input$rds[1])

    df2 <- readRDS(input$rds[2])

    id1 <- "subsets_MT_percent"

    id2 <- "high_subsets_MT_percent"

    use <- "higher"

    ann <- list(
        threshold = attr(df2[, id2], "thresholds")[use], 
        ncells = sum(df2[, id2])
    )

    plt <- ggplot(as.data.frame(df1), aes_string(x = id1)) + 
        geom_histogram(bins = 100, colour = "#849db1", fill = "#849db1") + 
        geom_vline(xintercept = ann$threshold, linetype = "dashed", colour = "#000000") + 
        annotate("text", x = ann$threshold, y = Inf, label = paste("Threshold", "=", round(ann$threshold, 2), " "), angle = 90, vjust = -1, hjust = 1, colour = "#000000") + 
        annotate("text", x = ann$threshold, y = Inf, label = paste("Discarded", "=", ann$ncells, " "), angle = 90, vjust = 2, hjust = 1, colour = "#000000") + 
        scale_x_continuous(name = "MT proportion", breaks = breaks_extended(), label = label_percent(scale = 1)) + 
        scale_y_continuous(name = "Number of cells", breaks = breaks_extended(), label = label_number_si()) + 
        theme_bw()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@log)