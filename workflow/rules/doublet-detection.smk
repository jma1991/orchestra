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