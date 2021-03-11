# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule findStrippedClusters:
    input:
        rds = ["results/doublet-detection/colDoublets.rds", "results/quality-control/perCellQCMetrics.rds"]
    output:
        rds = "results/stripped-detection/findStrippedClusters.rds"
    log:
        out = "results/stripped-detection/findStrippedClusters.out",
        err = "results/stripped-detection/findStrippedClusters.err"
    message:
        "[Stripped detection] Detect stripped nuclei clusters"
    script:
        "../scripts/stripped-detection/findStrippedClusters.R"

rule colStripped:
    input:
        rds = ["results/doublet-detection/colDoublets.rds", "results/stripped-detection/findStrippedClusters.rds"]
    output:
        rds = "results/stripped-detection/colStripped.rds"
    log:
        out = "results/stripped-detection/colStripped.out",
        err = "results/stripped-detection/colStripped.err"
    message:
        "[Stripped detection] Assign stripped nuclei clusters"
    script:
        "../scripts/stripped-detection/colStripped.R"

rule plotStrippedSina:
    input:
        rds = ["results/stripped-detection/colStripped.rds", "results/quality-control/perCellQCMetrics.rds"]
    output:
        pdf = "results/stripped-detection/plotStrippedSina.pdf"
    log:
        out = "results/stripped-detection/plotStrippedSina.out",
        err = "results/stripped-detection/plotStrippedSina.err"
    message:
        "[Stripped detection] Plot stripped nuclei by cluster"
    script:
        "../scripts/stripped-detection/plotStrippedSina.R"