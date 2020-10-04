# Clustering

rule buildSNNGraph:
    input:
        rds = "analysis/05-reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/clustering/buildSNNGraph.{k}.{type}.rds"
    params:
        k = "{k}",
        type = "{type}"
    log:
        out = "analysis/clustering/buildSNNGraph.{k}.{type}.out",
        err = "analysis/clustering/buildSNNGraph.{k}.{type}.err"
    message:
        "[Clustering] Build a nearest-neighbor graph (k = {params.k}, type = {params.type})"
    script:
        "../scripts/clustering/buildSNNGraph.R"

rule clustSNNGraph:
    input:
        rds = "analysis/clustering/buildSNNGraph.{k}.{type}.rds"
    output:
        rds = "analysis/clustering/clustSNNGraph.{k}.{type}.{fun}.rds"
    params:
        fun = "{fun}"
    log:
        out = "analysis/clustering/clustSNNGraph.{k}.{type}.{fun}.out",
        err = "analysis/clustering/clustSNNGraph.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Cluster the nearest-neighbor graph (cluster.fun = {params.fun})"
    script:
        "../scripts/clustering/clustSNNGraph.R"

rule clusterModularity:
    input:
        rds = ["analysis/clustering/buildSNNGraph.{k}.{type}.rds", "analysis/clustering/clustSNNGraph.{k}.{type}.{fun}.rds"]
    output:
        rds = "analysis/clustering/clusterModularity.{k}.{type}.{fun}.rds"
    log:
        out = "analysis/clustering/clusterModularity.{k}.{type}.{fun}.out",
        err = "analysis/clustering/clusterModularity.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Compute the cluster-wise modularity"
    script:
        "../scripts/clustering/clusterModularity.R"

rule plotClusterModularity:
    input:
        rds = "analysis/clustering/clusterModularity.{k}.{type}.{fun}.rds"
    output:
        pdf = "analysis/clustering/plotClusterModularity.{k}.{type}.{fun}.pdf"
    log:
        out = "analysis/clustering/plotClusterModularity.{k}.{type}.{fun}.out",
        err = "analysis/clustering/plotClusterModularity.{k}.{type}.{fun}.err"
    message:
        "[Clustering] Plot the cluster-wise modularity"
    script:
        "../scripts/clustering/plotClusterModularity.R"

rule colLabels:
    input:
        rds = ["analysis/04-feature-selection/setTopHVGs.rds", "analysis/clustering/clustSNNGraph.10.jaccard.louvain.rds"]
    output:
        rds = "analysis/clustering/colLabels.rds"
    log:
        out = "analysis/clustering/colLabels.out",
        err = "analysis/clustering/colLabels.err"
    message:
        "[Clustering]"
    script:
        "../scripts/clustering/colLabels.R"

"""
rule kmeans:
    input:
        rds = "analysis/05-reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/clustering/kmeans.{centers}.rds"
    log:
        out = "analysis/clustering/kmeans.{centers}.out",
        err = "analysis/clustering/kmeans.{centers}.err"
    params:
        centers = "{centers}"
    message:
        "[Clustering] Perform k-means clustering on PCA matrix with centers = {params.centers}"
    script:
        "../scripts/clustering/kmeans.R"

rule clusGap:
    input:
        rds = "analysis/05-reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/clustering/clusGap.rds"
    log:
        out = "analysis/clustering/clusGap.out",
        err = "analysis/clustering/clusGap.err"
    message:
        "[Clustering] Calculate gap statistic"
    script:
        "../scripts/clustering/clusGap.R"

rule maxSE:
    input:
        rds = "analysis/clustering/clusGap.rds"
    output:
        rds = "analysis/clustering/maxSE.rds"
    log:
        out = "analysis/clustering/maxSE.out",
        err = "analysis/clustering/maxSE.err"
    message:
        "[Clustering] Calculate gap statistic"
    script:
        "../scripts/clustering/maxSE.R"

rule wcss:
    input:
        rds = "analysis/clustering/kmeans.{num}.rds"
    output:
        csv = "analysis/clustering/kmeans.{num}.csv"
    script:
        "wcss.R"

rule centers:
    input:
        rds = "analysis/clustering/kmeans.{num}.rds"
    output:
        pdf = "analysis/clustering/kmeans.{num}.pdf"
    script:
        "centers.R"

rule hclust:
    input:
        rds = "analysis/clustering/logNormCounts.rds"
    output:
        rds = ["dist.rds", "hclust.rds"]
    message:
        "[Clustering] Perform hierarchical clustering on the PCA matrix"
    script:
        "hclust.R"

"""