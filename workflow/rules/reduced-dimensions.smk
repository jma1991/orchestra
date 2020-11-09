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

rule denoisePCA:
    input:
        rds = ["analysis/feature-selection/rowSubset.rds", "analysis/feature-selection/modelGeneVarByPoisson.rds"]
    output:
        rds = "analysis/reduced-dimensions/denoisePCA.rds"
    log:
        out = "analysis/reduced-dimensions/denoisePCA.out",
        err = "analysis/reduced-dimensions/denoisePCA.err"
    message:
        "[Dimensionality reduction] Denoise expression with PCA"
    script:
        "../scripts/reduced-dimensions/denoisePCA.R"

rule plotDenoisePCA:
    input:
        rds = ["analysis/reduced-dimensions/calculatePCA.rds", "analysis/reduced-dimensions/denoisePCA.rds"]
    output:
        pdf = "plotDenoisedPCs.pdf"
    script:
        "../scripts/reduced-dimensions/plotDenoisePCA.R"

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
        "[Dimensionality reduction]"
    script:
        "../scripts/reduced-dimensions/plotClusteredPCs.R"

rule selectPCs:
    input:
        rds = ["analysis/reduced-dimensions/calculatePCA.rds", "analysis/reduced-dimensions/findElbowPoint.rds"]
    output:
        rds = "runPCA.rds"
    message:
        "[Dimensionality reduction] Select number of PCs"
    script:
        "../scripts/reduced-dimensions/selectPCs.R"

rule parallelTSNE:
    input:
        rds = "analysis/reduced-dimensions/calculatePCA.rds"
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

rule _calculateTSNE:
    input:
        rds = "analysis/reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/reduced-dimensions/calculateTSNE.rds"
    script:
        "../scripts/reduced-dimensions/calculateTSNE.R"

rule parallelUMAP:
    input:
        rds = "analysis/reduced-dimensions/calculatePCA.rds"
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

rule runUMAP:
    input:
        rds = "SingleCellExperiment.rds"
    output:
        rds = "SingleCellExperiment.rds"
    script:
        "../scripts/reduced-dimensions/runUMAP.R"