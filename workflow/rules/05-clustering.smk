# Clustering

rule buildSNNGraph:
    input:
        rds = "calculatePCA.rds"
    output:
        rds = "analysis/05-clustering/buildSNNGraph-{k}-{type}.rds"
    params:
        k = 10,
        type = "rank"
    message:
        "[Clustering] Build the nearest-neighbor graph"
    script:
        "buildSNNGraph.R"

rule clusterSNNGraph:
    input:
        rds = "buildSNNGraph-{knn}-{snn}.rds"
    output:
        rds = "clusterSNNGraph-{knn}-{snn}-{fun}.rds"
    message:
        "[Clustering] Cluster the nearest-neighbor graph"
    script:
        "clusterSNNGraph.R"

rule clusterModularity:
    input:
        rds = ["buildSNNGraph-{knn}-{snn}.rds", "clusterSNNGraph-{knn}-{snn}-{fun}.rds"]
    output:
        pdf = "clusterModularity-{knn}-{snn}-{fun}.pdf"
    script:
        "clusterModularity.R"

rule clusGap:
    input:
        rds = "runPCA.rds"
    output:
        pdf = "clusGap.pdf"
    script:
        "clusGap.R"

rule kmeans:
    input:
        rds = "runPCA.rds"
    output:
        rds = "kmeans.{num}.rds"
    message:
        "[Clustering] Perform k-means clustering on the PCA matrix"
    script:
        "kmeans.R"

rule wcss:
    input:
        rds = "kmeans.{num}.rds"
    output:
        csv = "kmeans.{num}.csv"
    script:
        "wcss.R"

rule centers:
    input:
        rds = "kmeans.{num}.rds"
    output:
        pdf = "kmeans.{num}.pdf"
    script:
        "centers.R"

rule hclust:
    input:
        rds = "logNormCounts.rds"
    output:
        rds = ["dist.rds", "hclust.rds"]
    message:
        "[Clustering] Perform hierarchical clustering on the PCA matrix"
    script:
        "hclust.R"
