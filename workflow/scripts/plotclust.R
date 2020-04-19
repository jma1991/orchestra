#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    hcl <- readRDS(input$rds)

    pdf(output$pdf)
    
    plot(hcl, labels = FALSE, main = "Cluster dendrogram", hang = -1, cex = 0.6)

    dev.off()

}

main(snakemake@input, snakemake@output)