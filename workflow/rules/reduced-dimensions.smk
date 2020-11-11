# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule _calculatePCA:
    input:
        rds = "analysis/feature-selection/rowSubset.rds"
    output:
        rds = "analysis/reduced-dimensions/calculatePCA.rds"
    log:
        out = "analysis/reduced-dimensions/calculatePCA.out",
        err = "analysis/reduced-dimensions/calculatePCA.err"
    message:
        "[Dimensionality reduction] Perform PCA on expression data"
    script:
        "../scripts/reduced-dimensions/calculatePCA.R"

rule findElbowPoint:
    input:
        rds = "analysis/reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/reduced-dimensions/findElbowPoint.rds"
    log:
        out = "analysis/reduced-dimensions/findElbowPoint.out",
        err = "analysis/reduced-dimensions/findElbowPoint.err"
    message:
        "[Dimensionality reduction] Find the elbow point"
    script:
        "../scripts/reduced-dimensions/findElbowPoint.R"

rule plotElbowPoint:
    input:
        rds = ["analysis/reduced-dimensions/calculatePCA.rds", "analysis/reduced-dimensions/findElbowPoint.rds"]
    output:
        pdf = "analysis/reduced-dimensions/plotElbowPoint.pdf"
    log:
        out = "analysis/reduced-dimensions/plotElbowPoint.out",
        err = "analysis/reduced-dimensions/plotElbowPoint.err"
    message:
        "[Dimensionality reduction] Plot the elbow point"
    script:
        "../scripts/reduced-dimensions/plotElbowPoint.R"

rule getDenoisedPCs:
    input:
        rds = ["analysis/feature-selection/rowSubset.rds", "analysis/feature-selection/modelGeneVarByPoisson.rds"]
    output:
        rds = "analysis/reduced-dimensions/getDenoisedPCs.rds"
    log:
        out = "analysis/reduced-dimensions/getDenoisedPCs.out",
        err = "analysis/reduced-dimensions/getDenoisedPCs.err"
    message:
        "[Dimensionality reduction] Denoise expression with PCA"
    script:
        "../scripts/reduced-dimensions/getDenoisedPCs.R"

rule plotDenoisedPCs:
    input:
        rds = ["analysis/reduced-dimensions/calculatePCA.rds", "analysis/reduced-dimensions/getDenoisedPCs.rds"]
    output:
        pdf = "analysis/reduced-dimensions/plotDenoisedPCs.pdf"
    log:
        out = "analysis/reduced-dimensions/plotDenoisedPCs.out",
        err = "analysis/reduced-dimensions/plotDenoisedPCs.err"
    message:
        "[Dimensionality reduction] Plot denoised PCs"
    script:
        "../scripts/reduced-dimensions/plotDenoisedPCs.R"

rule getClusteredPCs:
    input:
        rds = "analysis/reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/reduced-dimensions/getClusteredPCs.rds"
    log:
        out = "analysis/reduced-dimensions/getClusteredPCs.out",
        err = "analysis/reduced-dimensions/getClusteredPCs.err"
    message:
        "[Dimensionality reduction] Use clusters to choose the number of PCs"
    script:
        "../scripts/reduced-dimensions/getClusteredPCs.R"

rule plotClusteredPCs:
    input:
        rds = "analysis/reduced-dimensions/getClusteredPCs.rds"
    output:
        pdf = "analysis/reduced-dimensions/plotClusteredPCs.pdf"
    log:
        out = "analysis/reduced-dimensions/plotClusteredPCs.out",
        err = "analysis/reduced-dimensions/plotClusteredPCs.err"
    message:
        "[Dimensionality reduction] Plot clustered PCs"
    script:
        "../scripts/reduced-dimensions/plotClusteredPCs.R"

rule selectPCA:
    input:
        rds = "analysis/reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/reduced-dimensions/selectPCA.rds"
    log:
        out = "analysis/reduced-dimensions/selectPCA.out",
        err = "analysis/reduced-dimensions/selectPCA.err"
    params:
        ncomponents = 7
    message:
        "[Dimensionality reduction] Select PCA"
    script:
        "../scripts/reduced-dimensions/selectPCA.R"

rule parallelTSNE:
    input:
        rds = "analysis/reduced-dimensions/selectPCA.rds"
    output:
        rds = "analysis/reduced-dimensions/parallelTSNE.rds"
    log:
        out = "analysis/reduced-dimensions/parallelTSNE.out",
        err = "analysis/reduced-dimensions/parallelTSNE.err"
    threads:
        16
    message:
        "[Dimensionality reduction] Perform parallel t-SNE on PCA matrix"
    script:
        "../scripts/reduced-dimensions/parallelTSNE.R"

rule visualiseTSNE:
    input:
        rds = "analysis/reduced-dimensions/parallelTSNE.rds"
    output:
        pdf = "analysis/reduced-dimensions/visualiseTSNE.pdf"
    log:
        out = "analysis/reduced-dimensions/visualiseTSNE.out",
        err = "analysis/reduced-dimensions/visualiseTSNE.err"
    script:
        "../scripts/reduced-dimensions/visualiseTSNE.R"

rule selectTSNE:
    input:
        rds = "analysis/reduced-dimensions/parallelTSNE.rds"
    output:
        rds = "analysis/reduced-dimensions/selectTSNE.rds"
    params:
        perplexity = 30,
        max_iter = 1000
    log:
        out = "analysis/reduced-dimensions/selectTSNE.out",
        err = "analysis/reduced-dimensions/selectTSNE.err"
    script:
        "../scripts/reduced-dimensions/selectTSNE.R"

rule parallelUMAP:
    input:
        rds = "analysis/reduced-dimensions/selectPCA.rds"
    output:
        rds = "analysis/reduced-dimensions/parallelUMAP.rds"
    log:
        out = "analysis/reduced-dimensions/parallelUMAP.out",
        err = "analysis/reduced-dimensions/parallelUMAP.err"
    threads:
        16
    message:
        "[Dimensionality reduction] Perform parallel UMAP on PCA matrix"
    script:
        "../scripts/reduced-dimensions/parallelUMAP.R"

rule visualiseUMAP:
    input:
        rds = "analysis/reduced-dimensions/parallelUMAP.rds"
    output:
        pdf = "analysis/reduced-dimensions/visualiseUMAP.pdf"
    log:
        out = "analysis/reduced-dimensions/visualiseUMAP.out",
        err = "analysis/reduced-dimensions/visualiseUMAP.err"
    message:
        "[Dimensionality reduction] Plot UMAP of PCA data"
    script:
        "../scripts/reduced-dimensions/visualiseUMAP.R"

rule selectUMAP:
    input:
        rds = "analysis/reduced-dimensions/parallelUMAP.rds"
    output:
        rds = "analysis/reduced-dimensions/selectUMAP.rds"
    params:
        n_neighbors = 30,
        min_dist = 0.01
    log:
        out = "analysis/reduced-dimensions/selectUMAP.out",
        err = "analysis/reduced-dimensions/selectUMAP.err"
    message:
        "[Dimensionality reduction] Select UMAP"
    script:
        "../scripts/reduced-dimensions/selectUMAP.R"

rule reducedDims:
    input:
        rds = ["analysis/feature-selection/rowSubset.rds",
               "analysis/reduced-dimensions/selectPCA.rds",
               "analysis/reduced-dimensions/selectTSNE.rds",
               "analysis/reduced-dimensions/selectUMAP.rds"]
    output:
        rds = "analysis/reduced-dimensions/reducedDims.rds"
    log:
        out = "analysis/reduced-dimensions/reducedDims.out",
        err = "analysis/reduced-dimensions/reducedDims.err"
    message:
        "[Dimensionality reduction]"
    script:
        "../scripts/reduced-dimensions/reducedDims.R"