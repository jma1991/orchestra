# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule calculatePCA:
    input:
        rds = "analysis/04-feature-selection/setTopHVGs.rds"
    output:
        rds = "analysis/05-reduced-dimensions/calculatePCA.rds"
    log:
        out = "analysis/05-reduced-dimensions/calculatePCA.out",
        err = "analysis/05-reduced-dimensions/calculatePCA.err"
    message:
        "[Dimensionality reduction] Perform PCA on expression data"
    script:
        "../scripts/05-reduced-dimensions/calculatePCA.R"

rule findElbowPoint:
    input:
        txt = "analysis/05-reduced-dimensions/calculatePCA.txt"
    output:
        txt = "analysis/05-reduced-dimensions/findElbowPoint.txt"
    log:
        out = "analysis/05-reduced-dimensions/findElbowPoint.out",
        err = "analysis/05-reduced-dimensions/findElbowPoint.err"
    message:
        "[Dimensionality reduction] Find the elbow point"
    script:
        "../scripts/05-reduced-dimensions/findElbowPoint.R"

rule plotElbowPoint:
    input:
        txt = ["analysis/05-reduced-dimensions/calculatePCA.txt", "analysis/05-reduced-dimensions/findElbowPoint.txt"]
    output:
        pdf = "analysis/05-reduced-dimensions/plotElbowPoint.pdf"
    log:
        out = "analysis/05-reduced-dimensions/plotElbowPoint.out",
        err = "analysis/05-reduced-dimensions/plotElbowPoint.err"
    message:
        "[Dimensionality reduction] Plot the elbow point"
    script:
        "../scripts/05-reduced-dimensions/plotElbowPoint.R"

rule getDenoisedPCs:
    input:
        rds = ["analysis/feature-selection/setTopHVGs.rds", "modelGeneVar.rds"]
    output:
        rds = "getDenoisedPCs.rds"
    script:
        "../scripts/05-reduced-dimensions/getDenoisedPCs.R"

rule plotDenoisedPCs:
    input:
        rds = ["calculatePCA.rds", "getDenoisedPCs.rds"]
    output:
        pdf = "plotDenoisedPCs.pdf"
    script:
        "../scripts/05-reduced-dimensions/plotDenoisedPCs.R"

rule getClusteredPCs:
    input:
        csv = "analysis/05-reduced-dimensions/calculatePCA.csv"
    output:
        csv = "analysis/05-reduced-dimensions/getClusteredPCs.csv",
        txt = "analysis/05-reduced-dimensions/getClusteredPCs.txt"
    log:
        out = "analysis/05-reduced-dimensions/getClusteredPCs.out",
        err = "analysis/05-reduced-dimensions/getClusteredPCs.err"
    message:
        "[Feature selection] Use clusters to choose the number of PCs"
    script:
        "../scripts/05-reduced-dimensions/getClusteredPCs.R"

rule plotClusteredPCs:
    input:
        csv = "analysis/05-reduced-dimensions/getClusteredPCs.csv",
        txt = "analysis/05-reduced-dimensions/getClusteredPCs.txt"
    output:
        pdf = "analysis/05-reduced-dimensions/plotClusteredPCs.pdf"
    log:
        out = "analysis/05-reduced-dimensions/plotClusteredPCs.out",
        err = "analysis/05-reduced-dimensions/plotClusteredPCs.err"
    script:
        "../scripts/05-reduced-dimensions/plotClusteredPCs.R"

rule selectPCs:
    input:
        rds = "calculatePCA.rds"
    output:
        rds = "runPCA.rds"
    params:
        num = 4
    message:
        "[Dimensionality reduction] Select number of PCs"
    script:
        "../scripts/05-reduced-dimensions/selectPCs.R"

rule parallelTSNE:
    input:
        rds = "analysis/05-reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/05-reduced-dimensions/parallelTSNE.rds"
    log:
        out = "analysis/05-reduced-dimensions/parallelTSNE.out",
        err = "analysis/05-reduced-dimensions/parallelTSNE.err"
    threads:
        16
    message:
        "[Dimensionality reduction] Perform parallel t-SNE on PCA matrix"
    script:
        "../scripts/05-reduced-dimensions/parallelTSNE.R"

rule visualiseTSNE:
    input:
        rds = "analysis/05-reduced-dimensions/parallelTSNE.rds"
    output:
        pdf = "analysis/05-reduced-dimensions/visualiseTSNE.pdf"
    log:
        out = "analysis/05-reduced-dimensions/visualiseTSNE.out",
        err = "analysis/05-reduced-dimensions/visualiseTSNE.err"
    script:
        "../scripts/05-reduced-dimensions/visualiseTSNE.R"

rule calculateTSNE:
    input:
        rds = "analysis/05-reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/05-reduced-dimensions/calculateTSNE.rds"
    script:
        "../scripts/05-reduced-dimensions/calculateTSNE.R"

rule parallelUMAP:
    input:
        rds = "analysis/05-reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/05-reduced-dimensions/parallelUMAP.rds"
    log:
        out = "analysis/05-reduced-dimensions/parallelUMAP.out",
        err = "analysis/05-reduced-dimensions/parallelUMAP.err"
    threads:
        16
    message:
        "[Dimensionality reduction] Perform parallel UMAP on PCA matrix"
    script:
        "../scripts/05-reduced-dimensions/parallelUMAP.R"

rule visualiseUMAP:
    input:
        rds = "analysis/05-reduced-dimensions/parallelUMAP.rds"
    output:
        pdf = "analysis/05-reduced-dimensions/visualiseUMAP.pdf"
    log:
        out = "analysis/05-reduced-dimensions/visualiseUMAP.out",
        err = "analysis/05-reduced-dimensions/visualiseUMAP.err"
    message:
        "[Dimensionality reduction] Plot UMAP of PCA data"
    script:
        "../scripts/05-reduced-dimensions/visualiseUMAP.R"

rule runUMAP:
    input:
        rds = "SingleCellExperiment.rds"
    output:
        rds = "SingleCellExperiment.rds"
    script:
        "../scripts/05-reduced-dimensions/runUMAP.R"