# Clustering

rule buildSNNGraph:
    input:
        rds = "analysis/05-reduced-dimensions/calculatePCA.rds"
    output:
        rds = "analysis/06-clustering/buildSNNGraph.rds"
    params:
        k = 10,
        type = "rank"
    message:
        "[Clustering] Build the nearest-neighbor graph"
    script:
        "buildSNNGraph.R"

"""
rule clusterSNNGraph:
    input:
        rds = "analysis/06-clustering/buildSNNGraph-{knn}-{snn}.rds"
    output:
        rds = "analysis/06-clustering/clusterSNNGraph-{knn}-{snn}-{fun}.rds"
    message:
        "[Clustering] Cluster the nearest-neighbor graph"
    script:
        "clusterSNNGraph.R"

rule clusterModularity:
    input:
        rds = ["analysis/06-clustering/buildSNNGraph-{knn}-{snn}.rds", "analysis/06-clustering/clusterSNNGraph-{knn}-{snn}-{fun}.rds"]
    output:
        pdf = "analysis/06-clustering/clusterModularity-{knn}-{snn}-{fun}.pdf"
    script:
        "clusterModularity.R"

rule clusGap:
    input:
        rds = "analysis/06-clustering/runPCA.rds"
    output:
        pdf = "analysis/06-clustering/clusGap.pdf"
    script:
        "clusGap.R"

rule kmeans:
    input:
        rds = "analysis/06-clustering/runPCA.rds"
    output:
        rds = "analysis/06-clustering/kmeans.{num}.rds"
    message:
        "[Clustering] Perform k-means clustering on the PCA matrix"
    script:
        "kmeans.R"

rule wcss:
    input:
        rds = "analysis/06-clustering/kmeans.{num}.rds"
    output:
        csv = "analysis/06-clustering/kmeans.{num}.csv"
    script:
        "wcss.R"

rule centers:
    input:
        rds = "analysis/06-clustering/kmeans.{num}.rds"
    output:
        pdf = "analysis/06-clustering/kmeans.{num}.pdf"
    script:
        "centers.R"

rule hclust:
    input:
        rds = "analysis/06-clustering/logNormCounts.rds"
    output:
        rds = ["dist.rds", "hclust.rds"]
    message:
        "[Clustering] Perform hierarchical clustering on the PCA matrix"
    script:
        "hclust.R"

"""