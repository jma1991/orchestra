#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("cluster", "scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds)

    set.seed(1701)
    
    fit <- clusGap(dim, kmeans, K.max = 20)

    num <- maxSE(fit$Tab[, "gap"], fit$Tab[, "SE.sim"])

    pdf(output$pdf)

    plot(fit$Tab[, "gap"], xlab = "Number of clusters", ylab = "Gap statistic")
    
    abline(v = num, col = "red")

    dev.off()

}

main(snakemake@input, snakemake@output)