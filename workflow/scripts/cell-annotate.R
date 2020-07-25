#!/usr/bin/env Rscript

main <- function(input, output) {

    
    set <- read.csv(input$csv)

    set <- split(set, )

    set <- lapply(set, function(x) GeneSet(x$gene_id, setName = ))

    set <- GeneSetCollection(set)


    fit <- AUCell_buildRankings(mat, plotStats = FALSE, verbose = FALSE)

    auc <- AUCell_calcAUC(all, fit)












}

main(snakemake@input, snakemake@output)