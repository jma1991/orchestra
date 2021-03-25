# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

# Hierarchical clustering

rule HclustParam:
    input:
        rds = "results/reduced-dimensions/selectPCA.rds"
    output:
        rds = "results/clustering/HclustParam.rds"
    params:
        metric = config["bluster"]["HclustParam"]["metric"],
        method = config["bluster"]["HclustParam"]["method"]
    log:
        out = "results/clustering/HclustParam.out",
        err = "results/clustering/HclustParam.err"
    message:
        "[Clustering] Perform hierarchical clustering (metric = '{params.metric}', method = '{params.method}')"
    script:
        "../scripts/clustering/HclustParam.R"

rule HclustPCAPlot:
    input:
        rds = ["results/reduced-dimensions/selectPCA.rds", "results/clustering/HclustParam.rds"]
    output:
        pdf = "results/clustering/HclustPCAPlot.pdf"
    log:
        out = "results/clustering/HclustPCAPlot.out",
        err = "results/clustering/HclustPCAPlot.err"
    message:
        "[Clustering] Plot PCA coloured by hierarchical clusters"
    script:
        "../scripts/clustering/HclustPCAPlot.R"

rule HclustTSNEPlot:
    input:
        rds = ["results/reduced-dimensions/selectTSNE.rds", "results/clustering/HclustParam.rds"]
    output:
        pdf = "results/clustering/HclustTSNEPlot.pdf"
    log:
        out = "results/clustering/HclustTSNEPlot.out",
        err = "results/clustering/HclustTSNEPlot.err"
    message:
        "[Clustering] Plot TSNE coloured by hierarchical clusters"
    script:
        "../scripts/clustering/HclustTSNEPlot.R"

rule HclustUMAPPlot:
    input:
        rds = ["results/reduced-dimensions/selectUMAP.rds", "results/clustering/HclustParam.rds"]
    output:
        pdf = "results/clustering/HclustUMAPPlot.pdf"
    log:
        out = "results/clustering/HclustUMAPPlot.out",
        err = "results/clustering/HclustUMAPPlot.err"
    message:
        "[Clustering] Plot UMAP coloured by hierarchical clusters"
    script:
        "../scripts/clustering/HclustUMAPPlot.R"

rule HclustSilhouette:
    input:
        rds = ["results/reduced-dimensions/selectPCA.rds", "results/clustering/HclustParam.rds"]
    output:
        rds = "results/clustering/HclustSilhouette.rds"
    log:
        out = "results/clustering/HclustSilhouette.out",
        err = "results/clustering/HclustSilhouette.err"
    message:
        "[Clustering] Approximate silhouette width"
    script:
        "../scripts/clustering/HclustSilhouette.R"

rule HclustSilhouettePlot:
    input:
        rds = "results/clustering/HclustSilhouette.rds"
    output:
        pdf = "results/clustering/HclustSilhouettePlot.pdf"
    log:
        out = "results/clustering/HclustSilhouettePlot.out",
        err = "results/clustering/HclustSilhouettePlot.err"
    message:
        "[Clustering] Plot silhouette width"
    script:
        "../scripts/clustering/HclustSilhouettePlot.R"

rule HclustPurity:
    input:
        rds = ["results/reduced-dimensions/selectPCA.rds", "results/clustering/HclustParam.rds"]
    output:
        rds = "results/clustering/HclustPurity.rds"
    log:
        out = "results/clustering/HclustPurity.out",
        err = "results/clustering/HclustPurity.err"
    message:
        "[Clustering] Compute neighborhood purity"
    script:
        "../scripts/clustering/HclustPurity.R"

rule HclustPurityPlot:
    input:
        rds = "results/clustering/HclustPurity.rds"
    output:
        pdf = "results/clustering/HclustPurityPlot.pdf"
    log:
        out = "results/clustering/HclustPurityPlot.out",
        err = "results/clustering/HclustPurityPlot.err"
    message:
        "[Clustering] Plot neighborhood purity"
    script:
        "../scripts/clustering/HclustPurityPlot.R"

# K-means clustering

rule KmeansParam:
    input:
        rds = "results/reduced-dimensions/selectPCA.rds"
    output:
        rds = "results/clustering/KmeansParam.rds"
    params:
        centers = config["bluster"]["KmeansParam"]["centers"]
    log:
        out = "results/clustering/KmeansParam.out",
        err = "results/clustering/KmeansParam.err"
    message:
        "[Clustering] Perform K-means clustering (centers = {params.centers})"
    script:
        "../scripts/clustering/KmeansParam.R"

rule KmeansPCAPlot:
    input:
        rds = ["results/reduced-dimensions/selectPCA.rds", "results/clustering/KmeansParam.rds"]
    output:
        pdf = "results/clustering/KmeansPCAPlot.pdf"
    log:
        out = "results/clustering/KmeansPCAPlot.out",
        err = "results/clustering/KmeansPCAPlot.err"
    message:
        "[Clustering] Plot PCA coloured by K-means clusters"
    script:
        "../scripts/clustering/KmeansPCAPlot.R"

rule KmeansTSNEPlot:
    input:
        rds = ["results/reduced-dimensions/selectTSNE.rds", "results/clustering/KmeansParam.rds"]
    output:
        pdf = "results/clustering/KmeansTSNEPlot.pdf"
    log:
        out = "results/clustering/KmeansTSNEPlot.out",
        err = "results/clustering/KmeansTSNEPlot.err"
    message:
        "[Clustering] Plot TSNE coloured by K-means clusters"
    script:
        "../scripts/clustering/KmeansTSNEPlot.R"

rule KmeansUMAPPlot:
    input:
        rds = ["results/reduced-dimensions/selectUMAP.rds", "results/clustering/KmeansParam.rds"]
    output:
        pdf = "results/clustering/KmeansUMAPPlot.pdf"
    log:
        out = "results/clustering/KmeansUMAPPlot.out",
        err = "results/clustering/KmeansUMAPPlot.err"
    message:
        "[Clustering] Plot UMAP coloured by K-means clusters"
    script:
        "../scripts/clustering/KmeansUMAPPlot.R"

rule KmeansSilhouette:
    input:
        rds = ["results/reduced-dimensions/selectPCA.rds", "results/clustering/KmeansParam.rds"]
    output:
        rds = "results/clustering/KmeansSilhouette.rds"
    log:
        out = "results/clustering/KmeansSilhouette.out",
        err = "results/clustering/KmeansSilhouette.err"
    message:
        "[Clustering] Approximate silhouette width"
    script:
        "../scripts/clustering/KmeansSilhouette.R"

rule KmeansSilhouettePlot:
    input:
        rds = "results/clustering/KmeansSilhouette.rds"
    output:
        pdf = "results/clustering/KmeansSilhouettePlot.pdf"
    log:
        out = "results/clustering/KmeansSilhouettePlot.out",
        err = "results/clustering/KmeansSilhouettePlot.err"
    message:
        "[Clustering] Plot silhouette width"
    script:
        "../scripts/clustering/KmeansSilhouettePlot.R"

rule KmeansPurity:
    input:
        rds = ["results/reduced-dimensions/selectPCA.rds", "results/clustering/KmeansParam.rds"]
    output:
        rds = "results/clustering/KmeansPurity.rds"
    log:
        out = "results/clustering/KmeansPurity.out",
        err = "results/clustering/KmeansPurity.err"
    message:
        "[Clustering] Compute neighborhood purity"
    script:
        "../scripts/clustering/KmeansPurity.R"

rule KmeansPurityPlot:
    input:
        rds = "results/clustering/KmeansPurity.rds"
    output:
        pdf = "results/clustering/KmeansPurityPlot.pdf"
    log:
        out = "results/clustering/KmeansPurityPlot.out",
        err = "results/clustering/KmeansPurityPlot.err"
    message:
        "[Clustering] Plot neighborhood purity"
    script:
        "../scripts/clustering/KmeansPurityPlot.R"

# Graph-based clustering

rule NNGraphParam:
    input:
        rds = "results/reduced-dimensions/selectPCA.rds"
    output:
        rds = "results/clustering/NNGraphParam.rds"
    params:
        k = config["bluster"]["NNGraphParam"]["k"],
        type = config["bluster"]["NNGraphParam"]["type"],
        fun = config["bluster"]["NNGraphParam"]["cluster.fun"]
    log:
        out = "results/clustering/NNGraphParam.out",
        err = "results/clustering/NNGraphParam.err"
    message:
        "[Clustering] Perform graph-based clustering (k = {params.k}, type = '{params.type}', cluster.fun = '{params.fun}')"
    script:
        "../scripts/clustering/NNGraphParam.R"

rule NNGraphPCAPlot:
    input:
        rds = ["results/reduced-dimensions/selectPCA.rds", "results/clustering/NNGraphParam.rds"]
    output:
        pdf = "results/clustering/NNGraphPCAPlot.pdf"
    log:
        out = "results/clustering/NNGraphPCAPlot.out",
        err = "results/clustering/NNGraphPCAPlot.err"
    message:
        "[Clustering] Plot PCA coloured by graph-based clusters"
    script:
        "../scripts/clustering/NNGraphPCAPlot.R"

rule NNGraphTSNEPlot:
    input:
        rds = ["results/reduced-dimensions/selectTSNE.rds", "results/clustering/NNGraphParam.rds"]
    output:
        pdf = "results/clustering/NNGraphTSNEPlot.pdf"
    log:
        out = "results/clustering/NNGraphTSNEPlot.out",
        err = "results/clustering/NNGraphTSNEPlot.err"
    message:
        "[Clustering] Plot TSNE coloured by graph-based clusters"
    script:
        "../scripts/clustering/NNGraphTSNEPlot.R"

rule NNGraphUMAPPlot:
    input:
        rds = ["results/reduced-dimensions/selectUMAP.rds", "results/clustering/NNGraphParam.rds"]
    output:
        pdf = "results/clustering/NNGraphUMAPPlot.pdf"
    log:
        out = "results/clustering/NNGraphUMAPPlot.out",
        err = "results/clustering/NNGraphUMAPPlot.err"
    message:
        "[Clustering] Plot UMAP coloured by graph-based clusters"
    script:
        "../scripts/clustering/NNGraphUMAPPlot.R"

rule NNGraphSilhouette:
    input:
        rds = ["results/reduced-dimensions/selectPCA.rds", "results/clustering/NNGraphParam.rds"]
    output:
        rds = "results/clustering/NNGraphSilhouette.rds"
    log:
        out = "results/clustering/NNGraphSilhouette.out",
        err = "results/clustering/NNGraphSilhouette.err"
    message:
        "[Clustering] Approximate silhouette width"
    script:
        "../scripts/clustering/NNGraphSilhouette.R"

rule NNGraphSilhouettePlot:
    input:
        rds = "results/clustering/NNGraphSilhouette.rds"
    output:
        pdf = "results/clustering/NNGraphSilhouettePlot.pdf"
    log:
        out = "results/clustering/NNGraphSilhouettePlot.out",
        err = "results/clustering/NNGraphSilhouettePlot.err"
    message:
        "[Clustering] Plot silhouette width"
    script:
        "../scripts/clustering/NNGraphSilhouettePlot.R"

rule NNGraphPurity:
    input:
        rds = ["results/reduced-dimensions/selectPCA.rds", "results/clustering/NNGraphParam.rds"]
    output:
        rds = "results/clustering/NNGraphPurity.rds"
    log:
        out = "results/clustering/NNGraphPurity.out",
        err = "results/clustering/NNGraphPurity.err"
    message:
        "[Clustering] Compute neighborhood purity"
    script:
        "../scripts/clustering/NNGraphPurity.R"

rule NNGraphPurityPlot:
    input:
        rds = "results/clustering/NNGraphPurity.rds"
    output:
        pdf = "results/clustering/NNGraphPurityPlot.pdf"
    log:
        out = "results/clustering/NNGraphPurityPlot.out",
        err = "results/clustering/NNGraphPurityPlot.err"
    message:
        "[Clustering] Plot neighborhood purity"
    script:
        "../scripts/clustering/NNGraphPurityPlot.R"

rule NNGraphModularity:
    input:
        rds = "results/clustering/NNGraphParam.rds"
    output:
        rds = "results/clustering/NNGraphModularity.rds"
    log:
        out = "results/clustering/NNGraphModularity.out",
        err = "results/clustering/NNGraphModularity.err"
    message:
        "[Clustering] Compute pairwise modularity"
    script:
        "../scripts/clustering/NNGraphModularity.R"

rule NNGraphModularityPlot:
    input:
        rds = "results/clustering/NNGraphModularity.rds"
    output:
        pdf = "results/clustering/NNGraphModularityPlot.pdf"
    log:
        out = "results/clustering/NNGraphModularityPlot.out",
        err = "results/clustering/NNGraphModularityPlot.err"
    message:
        "[Clustering] Plot pairwise modularity"
    script:
        "../scripts/clustering/NNGraphModularityPlot.R"

# Finalise clustering

rule clusterLabels:
    input:
        rds = ["results/reduced-dimensions/reducedDims.rds", "results/clustering/KmeansParam.rds"]
    output:
        rds = "results/clustering/clusterLabels.rds"
    log:
        out = "results/clustering/clusterLabels.out",
        err = "results/clustering/clusterLabels.err"
    message:
        "[Clustering] Assign cluster labels"
    script:
        "../scripts/clustering/clusterLabels.R"
