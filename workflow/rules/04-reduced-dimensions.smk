# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule calculatePCA:
    input:
        rds = "analysis/03-feature-selection/setTopHVGs.rds"
    output:
        rds = "analysis/04-reduced-dimensions/calculatePCA.rds"
    message:
        "[Dimensionality reduction] Perform PCA on expression data"
    script:
        "../scripts/04-reduced-dimensions/calculatePCA.R"

rule findElbowPoint:
    input:
        rds = "analysis/04-reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/04-reduced-dimensions/findElbowPoint.rds"
    message:
        "[Dimensionality reduction] Find the elbow point"
    script:
        "../scripts/04-reduced-dimensions/findElbowPoint.R"

rule plotElbowPoint:
    input:
        rds = ["analysis/04-reduced-dimensions/calculatePCA.rds", "analysis/04-reduced-dimensions/findElbowPoint.rds"]
    output:
        pdf = "analysis/04-reduced-dimensions/plotElbowPoint.pdf"
    message:
        "[Dimensionality reduction] Plot the elbow point"
    script:
        "../scripts/04-reduced-dimensions/plotElbowPoint.R"

rule getDenoisedPCs:
    input:
        rds = ["analysis/feature-selection/setTopHVGs.rds", "modelGeneVarWithSpikes.rds"]
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
        rds = "calculatePCA.rds"
    output:
        rds = "getClusteredPCs.rds"
    script:
        "../scripts/04-reduced-dimensions/getClusteredPCs.R"

rule plotClusteredPCs:
    input:
        rds = "getClusteredPCs.rds"
    output:
        pdf = "plotClusteredPCs.pdf"
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
        itr = [250, 500, 1000, 2000, 4050, 5000]
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
        num = [5, 15, 30, 50],
        dst = [0, 0.01, 0.05, 0.1, 0.5, 1]
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
