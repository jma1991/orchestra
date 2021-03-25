#!/usr/bin/env Rscript

breaks_log10 <- function() {

    # Return breaks

    trans_breaks("log10", function(x) 10 ^ x)

}

labels_log10 <- function() {

    # Return labels

    trans_format("log10", math_format(10 ^ .x))

}

theme_custom <- function() {

    # Return theme

    theme_bw() +
    theme(
        axis.title.x = element_text(margin = unit(c(1, 0, 0, 0), "lines")),
        axis.title.y = element_text(margin = unit(c(0, 1, 0, 0), "lines")),
    )

}

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggrepel)

    library(scales)

    dat <- readRDS(input$rds)

    dat <- as.data.frame(dat)

    dat <- subset(dat, mean > 0)
    
    fit <- mgcv::gam(dat$detected ~ s(log10(dat$mean), bs = "cs"))
    
    ind <- which(abs(fit$residuals) >= sort(abs(fit$residuals), decreasing = TRUE)[params$n], arr.ind = TRUE)

    dat$name <- ""

    dat$name[ind] <- dat$symbol[ind]

    plt <- ggplot(dat, aes(mean, detected, label = name)) + 
        geom_point(colour = "#BAB0AC") + 
        geom_text_repel(size = 1.65) + 
        scale_x_log10(name = "Mean", breaks = breaks_log10(), labels = labels_log10()) + 
        scale_y_continuous(name = "Detected", labels = label_percent(scale = 1)) + 
        theme_custom()

    ggsave(output$pdf, plot = plt, width = 8, height = 6, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)