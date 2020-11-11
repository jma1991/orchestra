#!/usr/bin/env Rscript

main <- function(input, output, log) {
    
    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggplot2)

    library(ggforce)

    library(gtools)

    dim <- readRDS(input$rds)

    dat <- lapply(dim, function(x) {

        y <- as.data.frame(x)

        y$perplexity <- attr(x, "perplexity")

        y$max_iter <- attr(x, "max_iter")

        y$params <- paste(y$perplexity, "/", y$max_iter)

        return(y)

    })

    dat <- do.call(rbind, dat)

    dat <- as.data.frame(dat)

    dat$params <- factor(dat$params, levels = mixedsort(unique(dat$params)))

    plt <- ggplot(dat, aes(TSNE1, TSNE2)) + 
        geom_point(size = 0.1) + 
        facet_wrap(~ params, scales = "free") + 
        ggtitle("perplexity / max_iter") + 
        theme_no_axes(theme_bw()) + 
        theme(aspect.ratio = 1, strip.background = element_blank())

    ggsave(output$pdf, plot = plt, width = 12, height = 12, scale = 0.8)

    # Image function

    library(magick)

    pdf <- image_read_pdf(output$pdf)

    pdf <- image_trim(pdf)

    pdf <- image_border(pdf, color = "#FFFFFF", geometry = "50x50")

    pdf <- image_write(pdf, path = output$pdf, format = "pdf")

}

main(snakemake@input, snakemake@output, snakemake@log)