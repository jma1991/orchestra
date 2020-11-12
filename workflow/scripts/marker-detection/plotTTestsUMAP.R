#!/usr/bin/env Rscript

plotUMAP <- function(features, object) {

    dat <- makePerCellDF(x = object, features = features)

    plt <- lapply(features, function(x) {
        ggplot(dat, aes_string("UMAP.1", "UMAP.2", colour = x)) + 
            geom_point() + 
            scale_colour_viridis_c() + 
            labs(x = "UMAP 1", y = "UMAP 2") + 
            theme_no_axes(theme_bw()) + 
            theme(aspect.ratio = 1)
    })

    out <- wrap_plots(plt)

}

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(ggforce)

    library(ggplot2)

    library(patchwork)

    library(scater)

    library(scran)

    sce <- readRDS(input$rds[1])

    res <- readRDS(input$rds[2])
    
    sig <- lapply(res, subset, FDR < 0.05)
    
    sig <- Filter(nrow, sig)

    top <- lapply(sig, head, n = 25)

    top <- lapply(top, rownames)

    plt <- lapply(top, plotUMAP, object = sce)

    dir <- dir.create(output$dir)

    ids <- paste0(output$dir, "/", names(top), ".pdf")

    plt <- mapply(ggsave, plot = plt, filename = ids, MoreArgs = list(scale = 0.8, width = 25, height = 25))

    # Image function

    library(magick)

    pdf <- lapply(ids, image_read_pdf)

    pdf <- lapply(pdf, image_trim)

    pdf <- lapply(pdf, image_border, color = "#FFFFFF", geometry = "50x50")

    pdf <- mapply(image_write, image = pdf, path = ids, MoreArgs = list(format = "pdf"))

}

main(snakemake@input, snakemake@output, snakemake@log)