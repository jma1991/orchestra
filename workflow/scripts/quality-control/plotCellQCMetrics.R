#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("ggplot2")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)

    pdf(output$pdf)

    par(mfrow = c(2, 2))

    boxplot(dat$sum, main = "Sum")

    boxplot(dat$detected, main = "Detected")

    if (!is.null(params$alt)) {

        ids <- paste("altexps", params$alt, "percent", sep = "_")

        alt <- dat[, ids, drop = FALSE]

        mapply(boxplot, x = alt, main = params$alt)

    }

    if (!is.null(params$sub)) {
        
        ids <- paste("subsets", params$sub, "percent", sep = "_")

        sub <- dat[, ids, drop = FALSE]

        mapply(boxplot, x = sub, main = params$sub)

    }

    dev.off()

}

main(snakemake@input, snakemake@output, snakemake@params)