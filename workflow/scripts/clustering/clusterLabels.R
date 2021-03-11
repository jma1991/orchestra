#!/usr/bin/env Rscript

palette <- function(x) {

    # Return colour blind palette

    library(hues)

    hue <- iwanthue(
        n = nlevels(x),
        hmin = 0,
        hmax = 360,
        cmin = 40,
        cmax = 70,
        lmin = 15,
        lmax = 85
    )
    
    names(hue) <- levels(x)

    hue[x]

}

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(SingleCellExperiment)

    sce <- readRDS(input$rds[1])

    mem <- readRDS(input$rds[2])

    sce$Cluster <- mem$clusters

    sce$Colour <- palette(mem$clusters)

    saveRDS(sce, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)