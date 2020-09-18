# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule calculatePCA:
    input:
        rds = "analysis/03-feature-selection/setTopHVGs.rds"
    output:
        csv = "analysis/04-reduced-dimensions/calculatePCA.csv",
        txt = "analysis/04-reduced-dimensions/calculatePCA.txt"
    log:
        out = "analysis/04-reduced-dimensions/calculatePCA.out",
        err = "analysis/04-reduced-dimensions/calculatePCA.err"
    message:
        "[Dimensionality reduction] Perform PCA on expression data"
    script:
        "../scripts/04-reduced-dimensions/calculatePCA.R"

rule findElbowPoint:
    input:
        txt = "analysis/04-reduced-dimensions/calculatePCA.txt"
    output:
        txt = "analysis/04-reduced-dimensions/findElbowPoint.txt"
    log:
        out = "analysis/04-reduced-dimensions/findElbowPoint.out",
        err = "analysis/04-reduced-dimensions/findElbowPoint.err"
    message:
        "[Dimensionality reduction] Find the elbow point"
    script:
        "../scripts/04-reduced-dimensions/findElbowPoint.R"

rule plotElbowPoint:
    input:
        txt = ["analysis/04-reduced-dimensions/calculatePCA.txt", "analysis/04-reduced-dimensions/findElbowPoint.txt"]
    output:
        pdf = "analysis/04-reduced-dimensions/plotElbowPoint.pdf"
    log:
        out = "analysis/04-reduced-dimensions/plotElbowPoint.out",
        err = "analysis/04-reduced-dimensions/plotElbowPoint.err"
    message:
        "[Dimensionality reduction] Plot the elbow point"
    script:
        "../scripts/04-reduced-dimensions/plotElbowPoint.R"

rule getDenoisedPCs:
    input:
        rds = ["analysis/feature-selection/setTopHVGs.rds", "modelGeneVar.rds"]
    output:
        rds = "getDenoisedPCs.rds"
    script:
        "../scripts/04-reduced-dimensions/getDenoisedPCs.R"

rule plotDenoisedPCs:
    input:
        rds = ["calculatePCA.rds", "getDenoisedPCs.rds"]
    output:
        pdf = "plotDenoisedPCs.pdf"
    script:
        "../scripts/04-reduced-dimensions/plotDenoisedPCs.R"

rule getClusteredPCs:
    input:
        csv = "analysis/04-reduced-dimensions/calculatePCA.csv"
    output:
        csv = "analysis/04-reduced-dimensions/getClusteredPCs.csv",
        txt = "analysis/04-reduced-dimensions/getClusteredPCs.txt"
    log:
        out = "analysis/04-reduced-dimensions/getClusteredPCs.out",
        err = "analysis/04-reduced-dimensions/getClusteredPCs.err"
    message:
        "[Feature selection] Use clusters to choose the number of PCs"
    script:
        "../scripts/04-reduced-dimensions/getClusteredPCs.R"

rule plotClusteredPCs:
    input:
        csv = "analysis/04-reduced-dimensions/getClusteredPCs.csv",
        txt = "analysis/04-reduced-dimensions/getClusteredPCs.txt"
    output:
        pdf = "analysis/04-reduced-dimensions/plotClusteredPCs.pdf"
    log:
        out = "analysis/04-reduced-dimensions/plotClusteredPCs.out",
        err = "analysis/04-reduced-dimensions/plotClusteredPCs.err"
    script:
        "../scripts/04-reduced-dimensions/plotClusteredPCs.R"

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
        "../scripts/04-reduced-dimensions/selectPCs.R"

rule calculateTSNE:
    input:
        rds = "analysis/04-reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/04-reduced-dimensions/calculateTSNE.rds"
    params:
        per = [5, 14, 23, 32, 41, 50],
        itr = [250, 500, 750, 1000, 1250]
    threads:
        16
    message:
        "[Dimensionality reduction] Perform t-SNE on PCA matrix"
    script:
        "../scripts/04-reduced-dimensions/calculateTSNE.R"

rule visualiseTSNE:
    input:
        rds = "analysis/04-reduced-dimensions/calculateTSNE.rds"
    output:
        pdf = "analysis/04-reduced-dimensions/visualiseTSNE.pdf"
    script:
        "../scripts/04-reduced-dimensions/visualiseTSNE.R"

rule runTSNE:
    input:
        rds = ["logNormCounts.rds", "calculateTSNE.rds"]
    output:
        rds = "runTSNE.rds"
    params:
        per = 30,
        itr = 1000
    script:
        "../scripts/04-reduced-dimensions/runTSNE.R"

rule calculateUMAP:
    input:
        rds = "analysis/04-reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/04-reduced-dimensions/calculateUMAP.rds"
    params:
        num = [2, 15, 30, 100],
        dst = [0.00, 0.25, 0.50, 0.75, 1.00] 
    threads:
        16
    message:
        "[Dimensionality reduction] Perform UMAP on PCA data"
    script:
        "../scripts/04-reduced-dimensions/calculateUMAP.R"

rule visualiseUMAP:
    input:
        rds = "analysis/04-reduced-dimensions/calculateUMAP.rds"
    output:
        pdf = "analysis/04-reduced-dimensions/visualiseUMAP.pdf"
    message:
        "[Dimensionality reduction] Plot UMAP of PCA data"
    script:
        "../scripts/04-reduced-dimensions/visualiseUMAP.R"

rule runUMAP:
    input:
        rds = "SingleCellExperiment.rds"
    output:
        rds = "SingleCellExperiment.rds"
    params:
        num = 30,
        dst = 0.05
    script:
        "../scripts/04-reduced-dimensions/runUMAP.R"
