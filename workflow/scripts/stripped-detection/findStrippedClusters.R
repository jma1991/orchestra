#!/usr/bin/env Rscript

findStrippedClusters <- function(x, clusters) {

    x <- x[, c("sum", "subsets_MT_percent")]

    x <- aggregate(x, list(clusters = clusters), median)

    x <- DataFrame(
        sum = x$sum,
        subsets_MT_percent = x$subsets_MT_percent,
        row.names = x$clusters
    )

    return(x)

}

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scuttle)

    sce <- readRDS(input$rds[1])

    dat <- readRDS(input$rds[2])

    ind <- colnames(sce)

    dat <- dat[ind, ]

    fit <- findStrippedClusters(dat, clusters = sce$Cluster)

    fit$stripped <- isOutlier(fit$subsets_MT_percent, type = "lower", log = TRUE)

    saveRDS(fit, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)