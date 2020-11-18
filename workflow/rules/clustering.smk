# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

# Hierarchical clustering

rule HclustParam:
    input:
        rds = "analysis/reduced-dimensions/selectPCs.rds"
    output:
        rds = "analysis/clustering/HclustParam.rds"
    log:
        out = "analysis/clustering/HclustParam.out",
        err = "analysis/clustering/HclustParam.err"
    message:
        "[Clustering] Perform hierarchical clustering"
    script:
        "../scripts/clustering/HclustParam.R"

rule HclustPCAPlot:
    input:
        rds = ["analysis/reduced-dimensions/selectPCs.rds", "analysis/clustering/HclustParam.rds"]
    output:
        pdf = "analysis/clustering/HclustPCAPlot.pdf"
    log:
        out = "analysis/clustering/HclustPCAPlot.out",
        err = "analysis/clustering/HclustPCAPlot.err"
    message:
        "[Clustering] Plot PCA coloured by hierarchical clusters"
    script:
        "../scripts/clustering/HclustPCAPlot.R"

rule HclustTSNEPlot:
    input:
        rds = ["analysis/reduced-dimensions/selectTSNE.rds", "analysis/clustering/HclustParam.rds"]
    output:
        pdf = "analysis/clustering/HclustTSNEPlot.pdf"
    log:
        out = "analysis/clustering/HclustTSNEPlot.out",
        err = "analysis/clustering/HclustTSNEPlot.err"
    message:
        "[Clustering] Plot TSNE coloured by hierarchical clusters"
    script:
        "../scripts/clustering/HclustTSNEPlot.R"

rule HclustUMAPPlot:
    input:
        rds = ["analysis/reduced-dimensions/selectUMAP.rds", "analysis/clustering/HclustParam.rds"]
    output:
        pdf = "analysis/clustering/HclustUMAPPlot.pdf"
    log:
        out = "analysis/clustering/HclustUMAPPlot.out",
        err = "analysis/clustering/HclustUMAPPlot.err"
    message:
        "[Clustering] Plot UMAP coloured by hierarchical clusters"
    script:
        "../scripts/clustering/HclustUMAPPlot.R"

rule HclustSilhouette:
    input:
        rds = ["analysis/reduced-dimensions/selectPCs.rds", "analysis/clustering/HclustParam.rds"]
    output:
        rds = "analysis/clustering/HclustSilhouette.rds"
    log:
        out = "analysis/clustering/HclustSilhouette.out",
        err = "analysis/clustering/HclustSilhouette.err"
    message:
        "[Clustering] Approximate silhouette width"
    script:
        "../scripts/clustering/HclustSilhouette.R"

rule HclustSilhouettePlot:
    input:
        rds = "analysis/clustering/HclustSilhouette.rds"
    output:
        pdf = "analysis/clustering/HclustSilhouettePlot.pdf"
    log:
        out = "analysis/clustering/HclustSilhouettePlot.out",
        err = "analysis/clustering/HclustSilhouettePlot.err"
    message:
        "[Clustering] Plot silhouette width"
    script:
        "../scripts/clustering/HclustSilhouettePlot.R"

rule HclustPurity:
    input:
        rds = ["analysis/reduced-dimensions/selectPCs.rds", "analysis/clustering/HclustParam.rds"]
    output:
        rds = "analysis/clustering/HclustPurity.rds"
    log:
        out = "analysis/clustering/HclustPurity.out",
        err = "analysis/clustering/HclustPurity.err"
    message:
        "[Clustering] Compute neighborhood purity"
    script:
        "../scripts/clustering/HclustPurity.R"

rule HclustPurityPlot:
    input:
        rds = "analysis/clustering/HclustPurity.rds"
    output:
        pdf = "analysis/clustering/HclustPurityPlot.pdf"
    log:
        out = "analysis/clustering/HclustPurityPlot.out",
        err = "analysis/clustering/HclustPurityPlot.err"
    message:
        "[Clustering] Plot neighborhood purity"
    script:
        "../scripts/clustering/HclustPurityPlot.R"

# K-means clustering

rule KmeansParam:
    input:
        rds = "analysis/reduced-dimensions/selectPCs.rds"
    output:
        rds = "analysis/clustering/KmeansParam.{centers}.rds"
    log:
        out = "analysis/clustering/KmeansParam.{centers}.out",
        err = "analysis/clustering/KmeansParam.{centers}.err"
    message:
        "[Clustering] Perform K-means clustering (centers = {wildcards.centers})"
    script:
        "../scripts/clustering/KmeansParam.R"

rule KmeansPCAPlot:
    input:
        rds = ["analysis/reduced-dimensions/selectPCs.rds", "analysis/clustering/KmeansParam.{centers}.rds"]
    output:
        pdf = "analysis/clustering/KmeansPCAPlot.{centers}.pdf"
    log:
        out = "analysis/clustering/KmeansPCAPlot.{centers}.out",
        err = "analysis/clustering/KmeansPCAPlot.{centers}.err"
    message:
        "[Clustering] Plot PCA coloured by K-means clusters"
    script:
        "../scripts/clustering/KmeansPCAPlot.R"

rule KmeansTSNEPlot:
    input:
        rds = ["analysis/reduced-dimensions/selectTSNE.rds", "analysis/clustering/KmeansParam.{centers}.rds"]
    output:
        pdf = "analysis/clustering/KmeansTSNEPlot.{centers}.pdf"
    log:
        out = "analysis/clustering/KmeansTSNEPlot.{centers}.out",
        err = "analysis/clustering/KmeansTSNEPlot.{centers}.err"
    message:
        "[Clustering] Plot TSNE coloured by K-means clusters"
    script:
        "../scripts/clustering/KmeansTSNEPlot.R"

rule KmeansUMAPPlot:
    input:
        rds = ["analysis/reduced-dimensions/selectUMAP.rds", "analysis/clustering/KmeansParam.{centers}.rds"]
    output:
        pdf = "analysis/clustering/KmeansUMAPPlot.{centers}.pdf"
    log:
        out = "analysis/clustering/KmeansUMAPPlot.{centers}.out",
        err = "analysis/clustering/KmeansUMAPPlot.{centers}.err"
    message:
        "[Clustering] Plot UMAP coloured by K-means clusters"
    script:
        "../scripts/clustering/KmeansUMAPPlot.R"

rule KmeansSilhouette:
    input:
        rds = ["analysis/reduced-dimensions/selectPCs.rds", "analysis/clustering/KmeansParam.{centers}.rds"]
    output:
        rds = "analysis/clustering/KmeansSilhouette.{centers}.rds"
    log:
        out = "analysis/clustering/KmeansSilhouette.{centers}.out",
        err = "analysis/clustering/KmeansSilhouette.{centers}.err"
    message:
        "[Clustering] Approximate silhouette width"
    script:
        "../scripts/clustering/KmeansSilhouette.R"

rule KmeansSilhouettePlot:
    input:
        rds = "analysis/clustering/KmeansSilhouette.{centers}.rds"
    output:
        pdf = "analysis/clustering/KmeansSilhouettePlot.{centers}.pdf"
    log:
        out = "analysis/clustering/KmeansSilhouettePlot.{centers}.out",
        err = "analysis/clustering/KmeansSilhouettePlot.{centers}.err"
    message:
        "[Clustering] Plot silhouette width"
    script:
        "../scripts/clustering/KmeansSilhouettePlot.R"

rule KmeansPurity:
    input:
        rds = ["analysis/reduced-dimensions/selectPCs.rds", "analysis/clustering/KmeansParam.{centers}.rds"]
    output:
        rds = "analysis/clustering/KmeansPurity.{centers}.rds"
    log:
        out = "analysis/clustering/KmeansPurity.{centers}.out",
        err = "analysis/clustering/KmeansPurity.{centers}.err"
    message:
        "[Clustering] Compute neighborhood purity"
    script:
        "../scripts/clustering/KmeansPurity.R"

rule KmeansPurityPlot:
    input:
        rds = "analysis/clustering/KmeansPurity.{centers}.rds"
    output:
        pdf = "analysis/clustering/KmeansPurityPlot.{centers}.pdf"
    log:
        out = "analysis/clustering/KmeansPurityPlot.{centers}.out",
        err = "analysis/clustering/KmeansPurityPlot.{centers}.err"
    message:
        "[Clustering] Plot neighborhood purity"
    script:
        "../scripts/clustering/KmeansPurityPlot.R"

# Graph-based clustering

rule NNGraphParam:
    input:
        rds = "analysis/reduced-dimensions/selectPCs.rds"
    output:
        rds = "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.rds"
    log:
        out = "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.out",
        err = "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Perform graph-based clustering (k = {wildcards.k}, type = '{wildcards.type}', cluster.fun = '{wildcards.fun}')"
    script:
        "../scripts/clustering/NNGraphParam.R"

rule NNGraphPCAPlot:
    input:
        rds = ["analysis/reduced-dimensions/selectPCs.rds", "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.rds"]
    output:
        pdf = "analysis/clustering/NNGraphPCAPlot.{k}.{type}.{fun}.pdf"
    log:
        out = "analysis/clustering/NNGraphPCAPlot.{k}.{type}.{fun}.out",
        err = "analysis/clustering/NNGraphPCAPlot.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Plot PCA coloured by graph-based clusters"
    script:
        "../scripts/clustering/NNGraphPCAPlot.R"

rule NNGraphTSNEPlot:
    input:
        rds = ["analysis/reduced-dimensions/selectTSNE.rds", "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.rds"]
    output:
        pdf = "analysis/clustering/NNGraphTSNEPlot.{k}.{type}.{fun}.pdf"
    log:
        out = "analysis/clustering/NNGraphTSNEPlot.{k}.{type}.{fun}.out",
        err = "analysis/clustering/NNGraphTSNEPlot.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Plot TSNE coloured by graph-based clusters"
    script:
        "../scripts/clustering/NNGraphTSNEPlot.R"

rule NNGraphUMAPPlot:
    input:
        rds = ["analysis/reduced-dimensions/selectUMAP.rds", "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.rds"]
    output:
        pdf = "analysis/clustering/NNGraphUMAPPlot.{k}.{type}.{fun}.pdf"
    log:
        out = "analysis/clustering/NNGraphUMAPPlot.{k}.{type}.{fun}.out",
        err = "analysis/clustering/NNGraphUMAPPlot.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Plot UMAP coloured by graph-based clusters"
    script:
        "../scripts/clustering/NNGraphUMAPPlot.R"

rule NNGraphSilhouette:
    input:
        rds = ["analysis/reduced-dimensions/selectPCs.rds", "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.rds"]
    output:
        rds = "analysis/clustering/NNGraphSilhouette.{k}.{type}.{fun}.rds"
    log:
        out = "analysis/clustering/NNGraphSilhouette.{k}.{type}.{fun}.out",
        err = "analysis/clustering/NNGraphSilhouette.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Approximate silhouette width"
    script:
        "../scripts/clustering/NNGraphSilhouette.R"

rule NNGraphSilhouettePlot:
    input:
        rds = "analysis/clustering/NNGraphSilhouette.{k}.{type}.{fun}.rds"
    output:
        pdf = "analysis/clustering/NNGraphSilhouettePlot.{k}.{type}.{fun}.pdf"
    log:
        out = "analysis/clustering/NNGraphSilhouettePlot.{k}.{type}.{fun}.out",
        err = "analysis/clustering/NNGraphSilhouettePlot.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Plot silhouette width"
    script:
        "../scripts/clustering/NNGraphSilhouettePlot.R"

rule NNGraphPurity:
    input:
        rds = ["analysis/reduced-dimensions/selectPCs.rds", "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.rds"]
    output:
        rds = "analysis/clustering/NNGraphPurity.{k}.{type}.{fun}.rds"
    log:
        out = "analysis/clustering/NNGraphPurity.{k}.{type}.{fun}.out",
        err = "analysis/clustering/NNGraphPurity.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Compute neighborhood purity"
    script:
        "../scripts/clustering/NNGraphPurity.R"

rule NNGraphPurityPlot:
    input:
        rds = "analysis/clustering/NNGraphPurity.{k}.{type}.{fun}.rds"
    output:
        pdf = "analysis/clustering/NNGraphPurityPlot.{k}.{type}.{fun}.pdf"
    log:
        out = "analysis/clustering/NNGraphPurityPlot.{k}.{type}.{fun}.out",
        err = "analysis/clustering/NNGraphPurityPlot.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Plot neighborhood purity"
    script:
        "../scripts/clustering/NNGraphPurityPlot.R"

rule NNGraphModularity:
    input:
        rds = "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.rds"
    output:
        rds = "analysis/clustering/NNGraphModularity.{k}.{type}.{fun}.rds"
    log:
        out = "analysis/clustering/NNGraphModularity.{k}.{type}.{fun}.out",
        err = "analysis/clustering/NNGraphModularity.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Compute pairwise modularity"
    script:
        "../scripts/clustering/NNGraphModularity.R"

rule NNGraphModularityPlot:
    input:
        rds = "analysis/clustering/NNGraphModularity.{k}.{type}.{fun}.rds"
    output:
        pdf = "analysis/clustering/NNGraphModularityPlot.{k}.{type}.{fun}.pdf"
    log:
        out = "analysis/clustering/NNGraphModularityPlot.{k}.{type}.{fun}.out",
        err = "analysis/clustering/NNGraphModularityPlot.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Plot pairwise modularity"
    script:
        "../scripts/clustering/NNGraphModularityPlot.R"

# Finalise clustering

rule clusterLabels:
    input:
        rds = ["analysis/reduced-dimensions/reducedDims.rds", "analysis/clustering/NNGraphParam.10.jaccard.louvain.rds"]
    output:
        rds = "analysis/clustering/clusterLabels.rds"
    log:
        out = "analysis/clustering/clusterLabels.out",
        err = "analysis/clustering/clusterLabels.err"
    message:
        "[Clustering] Assign cluster labels"
    script:
        "../scripts/clustering/clusterLabels.R"