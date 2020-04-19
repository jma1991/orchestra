#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("robustbase", "scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)

    var <- DataFrame(lib_size = log10(dat$sum), n_features = log10(dat$detected))

    if (!is.null(params$alt)) {
        
        ids <- paste("altexps", params$alt, "percent", sep = "_")

        alt <- dat[, ids, drop = FALSE]

        var <- cbind(var, alt)

    }

    if (!is.null(params$sub)) {
        
        ids <- paste("subsets", params$sub, "percent", sep = "_")

        sub <- dat[, ids, drop = FALSE]
        
        var <- append(var, sub)
    
    }

    adj <- adjOutlyingness(var, only.outlyingness = TRUE)
    
    lgl <- isOutlier(adj, type = "higher")

    fit <- DataFrame(discard = lgl)

    saveRDS(fit, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params)