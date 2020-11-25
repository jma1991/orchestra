# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule _calculatePCA:
    input:
        rds = "analysis/feature-selection/rowSubset.rds"
    output:
        rds = "analysis/reduced-dimensions/calculatePCA.rds"
    params:
        ncomponents = config["calculatePCA"]["ncomponents"]
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
        rds = ["analysis/reduced-dimensions/getClusteredPCs.rds", "analysis/reduced-dimensions/clusterPCANumber.rds"]
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

rule selectPCs:
    input:
        rds = ["analysis/reduced-dimensions/calculatePCA.rds", "analysis/reduced-dimensions/getDenoisedPCs.rds"]
    output:
        rds = "analysis/reduced-dimensions/selectPCs.rds"
    log:
        out = "analysis/reduced-dimensions/selectPCs.out",
        err = "analysis/reduced-dimensions/selectPCs.err"
    message:
        "[Dimensionality reduction] Select PCs"
    script:
        "../scripts/reduced-dimensions/selectPCs.R"

rule parallelTSNE:
    input:
        rds = "analysis/reduced-dimensions/selectPCs.rds"
    output:
        rds = "analysis/reduced-dimensions/parallelTSNE.rds"
    params:
        perplexity = config["parallelTSNE"]["perplexity"],
        max_iter = config["parallelTSNE"]["max_iter"]
    log:
        out = "analysis/reduced-dimensions/parallelTSNE.out",
        err = "analysis/reduced-dimensions/parallelTSNE.err"
    threads:
        16
    message:
        "[Dimensionality reduction] Perform parallel TSNE on PCA matrix"
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
    message:
        "[Dimensionality reduction] Plot parallel TSNE"
    script:
        "../scripts/reduced-dimensions/visualiseTSNE.R"

rule selectTSNE:
    input:
        rds = "analysis/reduced-dimensions/parallelTSNE.rds"
    output:
        rds = "analysis/reduced-dimensions/selectTSNE.rds"
    params:
        perplexity = config["calculateTSNE"]["perplexity"],
        max_iter = config["calculateTSNE"]["max_iter"]
    log:
        out = "analysis/reduced-dimensions/selectTSNE.out",
        err = "analysis/reduced-dimensions/selectTSNE.err"
    message:
        "[Dimensionality reduction] Select TSNE matrix"
    script:
        "../scripts/reduced-dimensions/selectTSNE.R"

rule parallelUMAP:
    input:
        rds = "analysis/reduced-dimensions/selectPCs.rds"
    output:
        rds = "analysis/reduced-dimensions/parallelUMAP.rds"
    params:
        n_neighbors = config["parallelUMAP"]["n_neighbors"],
        min_dist = config["parallelUMAP"]["min_dist"]
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
        "[Dimensionality reduction] Plot parallel UMAP"
    script:
        "../scripts/reduced-dimensions/visualiseUMAP.R"

rule selectUMAP:
    input:
        rds = "analysis/reduced-dimensions/parallelUMAP.rds"
    output:
        rds = "analysis/reduced-dimensions/selectUMAP.rds"
    params:
        n_neighbors = config["calculateUMAP"]["n_neighbors"],
        min_dist = config["calculateUMAP"]["min_dist"]
    log:
        out = "analysis/reduced-dimensions/selectUMAP.out",
        err = "analysis/reduced-dimensions/selectUMAP.err"
    message:
        "[Dimensionality reduction] Select UMAP matrix"
    script:
        "../scripts/reduced-dimensions/selectUMAP.R"

rule reducedDims:
    input:
        rds = ["analysis/feature-selection/rowSubset.rds",
               "analysis/reduced-dimensions/selectPCs.rds",
               "analysis/reduced-dimensions/selectTSNE.rds",
               "analysis/reduced-dimensions/selectUMAP.rds"]
    output:
        rds = "analysis/reduced-dimensions/reducedDims.rds"
    log:
        out = "analysis/reduced-dimensions/reducedDims.out",
        err = "analysis/reduced-dimensions/reducedDims.err"
    message:
        "[Dimensionality reduction] Add reducedDims to SingleCellExperiment"
    script:
        "../scripts/reduced-dimensions/reducedDims.R"