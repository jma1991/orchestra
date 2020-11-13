# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule perCellEntropy:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/trajectory/perCellEntropy.rds"
    log:
        out = "analysis/trajectory/perCellEntropy.out",
        err = "analysis/trajectory/perCellEntropy.err"
    message:
        "[Trajectory analysis] Compute the per-cell entropy"
    script:
        "../scripts/trajectory/perCellEntropy.R"

rule plotEntropy:
    input:
        rds = ["analysis/clustering/colLabels.rds", "analysis/trajectory/perCellEntropy.rds"]
    output:
        pdf = "analysis/trajectory/plotEntropy.pdf"
    log:
        out = "analysis/trajectory/plotEntropy.out",
        err = "analysis/trajectory/plotEntropy.err"
    message:
        "[Trajectory analysis] Plot the per-cell entropy"
    script:
        "../scripts/trajectory/plotEntropy.R"

rule slingshot:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/trajectory/slingshot.rds"
    log:
        out = "analysis/trajectory/slingshot.out",
        err = "analysis/trajectory/slingshot.err"
    message:
        "[Trajectory analysis] Perform lineage inference with Slingshot"
    script:
        "../scripts/trajectory/slingshot.R"

rule plotCurves:
    input:
        rds = ["analysis/clustering/colLabels.rds", "analysis/trajectory/slingshot.rds"]
    output:
        pdf = "analysis/trajectory/plotCurves.pdf"
    log:
        out = "analysis/trajectory/plotCurves.out",
        err = "analysis/trajectory/plotCurves.err"
    message:
        "[Trajectory analysis]"
    script:
        "../scripts/trajectory/plotCurves.R"


rule scvelo:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/trajectory/scvelo.rds"
    log:
        out = "analysis/trajectory/scvelo.out",
        err = "analysis/trajectory/scvelo.err"
    script:
        "../scripts/trajectory/scvelo.R"

rule plotVelo:
    input:
        rds = ["analysis/clustering/colLabels.rds", "analysis/trajectory/scvelo.rds"]
    output:
        pdf = "analysis/trajectory/plotVelo.pdf"
    log:
        out = "analysis/trajectory/plotVelo.out",
        err = "analysis/trajectory/plotVelo.err"
    script:
        "../scripts/trajectory/plotVelo.R"