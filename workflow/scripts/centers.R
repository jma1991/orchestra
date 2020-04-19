#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("graphics", "stats")

    lib <- lapply(pkg, library, character.only = TRUE)

    fit <- readRDS(input$rds)

    dis <- dist(fit$centers)

    hcl <- hclust(dis, "ward.D2")

    pdf(output$pdf)
    
    plot(hcl)

    dev.off()

}

main(snakemake@input, snakemake@output)