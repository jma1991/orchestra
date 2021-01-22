# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule DoubletDetection_findDoubletClusters:
    input:
        rds = "results/clustering/clusterLabels.rds"
    output:
        rds = "results/doublet-detection/findDoubletClusters.rds"
    log:
        out = "results/doublet-detection/findDoubletClusters.out",
        err = "results/doublet-detection/findDoubletClusters.err"
    message:
        "[Doublet detection] Detect doublet clusters"
    script:
        "../scripts/doublet-detection/findDoubletClusters.R"

rule DoubletDetection_nameDoubletClusters:
    input:
        rds = "results/doublet-detection/findDoubletClusters.rds"
    output:
        rds = "results/doublet-detection/nameDoubletClusters.rds"
    params:
        nmads = config["findDoubletClusters"]["nmads"]
    log:
        out = "results/doublet-detection/nameDoubletClusters.out",
        err = "results/doublet-detection/nameDoubletClusters.err"
    message:
        "[Doublet detection] Return name of doublet clusters"
    script:
        "../scripts/doublet-detection/nameDoubletClusters.R"

rule DoubletDetection_computeDoubletDensity:
    input:
        rds = "results/clustering/clusterLabels.rds"
    output:
        rds = "results/doublet-detection/computeDoubletDensity.rds"
    log:
        out = "results/doublet-detection/computeDoubletDensity.out",
        err = "results/doublet-detection/computeDoubletDensity.err"
    message:
        "[Doublet detection] Compute the density of simulated doublets"
    script:
        "../scripts/doublet-detection/computeDoubletDensity.R"

rule DoubletDetection_mockDoubletSCE:
    input:
        rds = ["results/clustering/clusterLabels.rds", "results/doublet-detection/nameDoubletClusters.rds", "results/doublet-detection/computeDoubletDensity.rds"]
    output:
        rds = "results/doublet-detection/mockDoubletSCE.rds"
    log:
        out = "results/doublet-detection/mockDoubletSCE.out",
        err = "results/doublet-detection/mockDoubletSCE.err"
    message:
        "[Doublet detection] Assign doublet clusters"
    script:
        "../scripts/doublet-detection/mockDoubletSCE.R"

rule DoubletDetection_plotDoubletSina:
    input:
        rds = "results/doublet-detection/mockDoubletSCE.rds"
    output:
        pdf = "results/doublet-detection/plotDoubletSina.pdf"
    log:
        out = "results/doublet-detection/plotDoubletSina.out",
        err = "results/doublet-detection/plotDoubletSina.err"
    message:
        "[Doublet detection] Plot doublet density by cluster"
    script:
        "../scripts/doublet-detection/plotDoubletSina.R"

rule DoubletDetection_plotDoubletPCA:
    input:
        rds = "results/doublet-detection/mockDoubletSCE.rds"
    output:
        pdf = "results/doublet-detection/plotDoubletPCA.pdf"
    log:
        out = "results/doublet-detection/plotDoubletPCA.out",
        err = "results/doublet-detection/plotDoubletPCA.err"
    message:
        "[Doublet detection] Plot PCA coloured by doublet density"
    script:
        "../scripts/doublet-detection/plotDoubletPCA.R"

rule DoubletDetection_plotDoubletTSNE:
    input:
        rds = "results/doublet-detection/mockDoubletSCE.rds"
    output:
        pdf = "results/doublet-detection/plotDoubletTSNE.pdf"
    log:
        out = "results/doublet-detection/plotDoubletTSNE.out",
        err = "results/doublet-detection/plotDoubletTSNE.err"
    message:
        "[Doublet detection] Plot TSNE coloured by doublet density"
    script:
        "../scripts/doublet-detection/plotDoubletTSNE.R"

rule DoubletDetection_plotDoubletUMAP:
    input:
        rds = "results/doublet-detection/mockDoubletSCE.rds"
    output:
        pdf = "results/doublet-detection/plotDoubletUMAP.pdf"
    log:
        out = "results/doublet-detection/plotDoubletUMAP.out",
        err = "results/doublet-detection/plotDoubletUMAP.err"
    message:
        "[Doublet detection] Plot UMAP coloured by doublet density"
    script:
        "../scripts/doublet-detection/plotDoubletUMAP.R"
