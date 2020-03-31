# Clustering

rule buildSNNGraph:
    input:
        rds = "runPCA.rds"
    output:
        rds = "buildSNNGraph-{knn}-{snn}.rds"
    script:
        "buildSNNGraph.R"

rule clusterSNNGraph:
    input:
        rds = "buildSNNGraph-{knn}-{snn}.rds"
    output:
        rds = "clusterSNNGraph-{knn}-{snn}-{fun}.rds"
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
    script:
        "hclust.R"
