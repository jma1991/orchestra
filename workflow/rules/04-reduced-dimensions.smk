rule calculatePCA:
    input:
        rds = "logNormcounts.rds"
    output:
        rds = "calculatePCA.rds"
    message:
        "[Dimensionality reduction] Perform PCA on expression data"
    script:
        "calculatePCA.R"

rule findElbowPoint:
    input:
        rds = "calculatePCA.rds"
    output:
        rds = "findElbowPoint.rds"
    message:
        "[Dimensionality reduction] Find the elbow point"
    script:
        "findElbowPoint.R"

rule plotElbowPoint:
    input:
        rds = ["calculatePCA.rds", "findElbowPoint.rds"]
    output:
        pdf = "plotElbowPoint.pdf"
    message:
        "[Dimensionality reduction] Plot the elbow point"
    script:
        "plotElbowPoint.R"

rule getDenoisedPCs:
    input:
        rds = ["logNormCounts.rds", "modelGeneVarWithSpikes.rds"]
    output:
        rds = "getDenoisedPCs.rds"
    script:
        "getDenoisedPCs.R"

rule plotDenoisedPCs:
    input:
        rds = ["calculatePCA.rds", "getDenoisedPCs.rds"]
    output:
        pdf = "plotDenoisedPCs.pdf"
    script:
        "plotDenoisedPCs.R"

rule getClusteredPCs:
    input:
        rds = "calculatePCA.rds"
    output:
        rds = "getClusteredPCs.rds"
    script:
        "getClusteredPCs.R"

rule plotClusteredPCs:
    input:
        rds = "getClusteredPCs.rds"
    output:
        pdf = "plotClusteredPCs.pdf"
    script:
        "plotClusteredPCs.R"

rule runPCA:
    input:
        rds = "calculatePCA.rds"
    output:
        rds = "runPCA.rds"
    params:
        num = 4
    message:
        "[Dimensionality reduction] "
    script:
        "runPCA.R"

rule calculateTSNE:
    input:
        rds = "runPCA.rds"
    output:
        rds = "calculateTSNE.rds"
    params:
        per = [5, 15, 30],
        itr = [500, 1500, 3000, 5000, 10000]
    threads:
        16
    message:
        "[Dimensionality reduction] Perform t-SNE on PCA matrix"
    script:
        "calculateTSNE.R"

rule visualiseTSNE:
    input:
        rds = "calculateTSNE.rds"
    output:
        pdf = "visualiseTSNE.pdf"
    script:
        "visualiseTSNE.R"

rule runTSNE:
    input:
        rds = ["logNormCounts.rds", "calculateTSNE.rds"]
    output:
        rds = "runTSNE.rds"
    params:
        per = 30,
        itr = 1000
    script:
        "runTSNE.R"

rule calculateUMAP:
    input:
        rds = "calculatePCA.rds"
    output:
        rds = "calculateUMAP.rds"
    params:
        num = [5, 15, 30, 50],
        dst = [0, 0.01, 0.05, 0.1, 0.5, 1]
    threads:
        16
    message:
        "[Dimensionality reduction] Perform UMAP on PCA data"
    script:
        "calculateUMAP.R"

rule visualiseUMAP:
    input:
        rds = "calculateUMAP.rds"
    output:
        pdf = "visualiseUMAP.pdf"
    message:
        "[Dimensionality reduction] Plot UMAP projection of PCA data"
    script:
        "visualiseUMAP.R"

rule runUMAP:
    input:
        rds = "SingleCellExperiment.rds"
    output:
        rds = "SingleCellExperiment.rds"
    params:
        num = 30,
        dst = 0.05
    script:
        "runUMAP.R"
