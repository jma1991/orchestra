# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule findDoubletClusters:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/doublet-detection/findDoubletClusters.rds"
    log:
        out = "analysis/doublet-detection/findDoubletClusters.out",
        err = "analysis/doublet-detection/findDoubletClusters.err"
    message:
        "[Doublet detection] Detect doublet clusters"
    script:
        "../scripts/doublet-detection/findDoubletClusters.R"

rule computeDoubletDensity:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/doublet-detection/computeDoubletDensity.rds"
    log:
        out = "analysis/doublet-detection/computeDoubletDensity.out",
        err = "analysis/doublet-detection/computeDoubletDensity.err"
    message:
        "[Doublet detection] Compute the density of simulated doublets"
    script:
        "../scripts/doublet-detection/computeDoubletDensity.R"

rule mockDoubletSCE:
    input:
        rds = ["analysis/clustering/colLabels.rds", "analysis/doublet-detection/findDoubletClusters.rds", "analysis/doublet-detection/computeDoubletDensity.rds"]
    output:
        rds = "analysis/doublet-detection/mockDoubletSCE.rds"
    log:
        out = "analysis/doublet-detection/mockDoubletSCE.out",
        err = "analysis/doublet-detection/mockDoubletSCE.err"
    message:
        "[Doublet detection]"
    script:
        "../scripts/doublet-detection/mockDoubletSCE.R"

rule plotDoubletSina:
    input:
        rds = "analysis/doublet-detection/mockDoubletSCE.rds"
    output:
        pdf = "analysis/doublet-detection/plotDoubletSina.pdf"
    log:
        out = "analysis/doublet-detection/plotDoubletSina.out",
        err = "analysis/doublet-detection/plotDoubletSina.err"
    message:
        "[Doublet detection] Plot doublet density by cluster"
    script:
        "../scripts/doublet-detection/plotDoubletSina.R"

rule plotDoubletPCA:
    input:
        rds = "analysis/doublet-detection/mockDoubletSCE.rds"
    output:
        pdf = "analysis/doublet-detection/plotDoubletPCA.pdf"
    log:
        out = "analysis/doublet-detection/plotDoubletPCA.out",
        err = "analysis/doublet-detection/plotDoubletPCA.err"
    message:
        "[Doublet detection] Plot PCA coloured by doublet density"
    script:
        "../scripts/doublet-detection/plotDoubletPCA.R"

rule plotDoubletTSNE:
    input:
        rds = "analysis/doublet-detection/mockDoubletSCE.rds"
    output:
        pdf = "analysis/doublet-detection/plotDoubletTSNE.pdf"
    log:
        out = "analysis/doublet-detection/plotDoubletTSNE.out",
        err = "analysis/doublet-detection/plotDoubletTSNE.err"
    message:
        "[Doublet detection] Plot TSNE coloured by doublet density"
    script:
        "../scripts/doublet-detection/plotDoubletTSNE.R"

rule plotDoubletUMAP:
    input:
        rds = "analysis/doublet-detection/mockDoubletSCE.rds"
    output:
        pdf = "analysis/doublet-detection/plotDoubletUMAP.pdf"
    log:
        out = "analysis/doublet-detection/plotDoubletUMAP.out",
        err = "analysis/doublet-detection/plotDoubletUMAP.err"
    message:
        "[Doublet detection] Plot UMAP coloured by doublet density"
    script:
        "../scripts/doublet-detection/plotDoubletUMAP.R"