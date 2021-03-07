#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function
    
    library(scater)
        
    sce <- readRDS(input$rds[1])
    
    dat <- readRDS(input$rds[2])

    ind <- list(
        Pass = !dat$discard,
        Fail = dat$discard
    )

    mat <- cbind(
        Pass = calculateAverage(counts(sce)[, ind$Pass]),
        Fail = calculateAverage(counts(sce)[, ind$Fail])
    )
    
    cpm <- edgeR::cpm(mat, log = TRUE, prior.count = 2)

    ave <- rowMeans(cpm)

    lfc <- mat[, "Pass"] - mat[, "Fail"]
    
    tab <- rowSums(counts(sce) > 0) / ncol(sce)

    res <- data.frame(ID = rowData(sce)$ID, Symbol = rowData(sce)$Symbol, Prop = tab, logCPM = ave, logFC = lfc)

    saveRDS(res, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)