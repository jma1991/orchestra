#!/usr/bin/env Rscript

theme_custom <- function() {

    # Return custom theme

    theme_bw() +
    theme(
        axis.title.x = element_text(margin = unit(c(1, 0, 0, 0), "lines")),
        axis.title.y = element_text(margin = unit(c(0, 1, 0, 0), "lines")),
        strip.background = element_blank(),
        legend.position = "none"
    )

}

main <- function(input, output, params, log) {
    
    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(bluster)

    library(ggforce)

    dim <- readRDS(input$rds)

    dat <- as.data.frame(dim)

    num <- pmin(ncol(dim), params$ncomponents)

    var <- paste("PCA", seq_len(num), sep = ".")

    mem <- clusterRows(dim, NNGraphParam())
    
    dat <- as.data.frame(dim)
    
    dat$cluster <- mem

    plt <- ggplot(dat, aes(x = .panel_x, y = .panel_y, colour = cluster, fill = cluster)) +  
        geom_point(size = 0.1) + 
        geom_autodensity() +
        geom_density2d() + 
        facet_matrix(
            rows = vars({{var}}),
            layer.lower = 1,
            layer.diag = 2,
            layer.upper = 3,
            grid.y.diag = FALSE
        ) + 
        theme_custom()

    ggsave(output$pdf, plot = plt, width = 12, height = 12, scale = 0.8)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)