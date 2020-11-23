# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule perCellEntropy:
    input:
        rds = "analysis/cell-cycle/addPerCellPhase.rds"
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
        rds = ["analysis/cell-cycle/addPerCellPhase.rds", "analysis/trajectory/perCellEntropy.rds"]
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
        rds = "analysis/cell-cycle/addPerCellPhase.rds"
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
        rds = ["analysis/cell-cycle/addPerCellPhase.rds", "analysis/trajectory/slingshot.rds"]
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
        rds = "analysis/cell-cycle/addPerCellPhase.rds"
    output:
        rds = "analysis/trajectory/scvelo.rds"
    log:
        out = "analysis/trajectory/scvelo.out",
        err = "analysis/trajectory/scvelo.err"
    message:
        "[Trajectory analysis] RNA velocity with scVelo"
    threads:
        16
    script:
        "../scripts/trajectory/scvelo.R"

rule plotVeloPCA:
    input:
        rds = ["analysis/cell-cycle/addPerCellPhase.rds", "analysis/trajectory/scvelo.rds"]
    output:
        pdf = "analysis/trajectory/plotVeloPCA.pdf"
    log:
        out = "analysis/trajectory/plotVeloPCA.out",
        err = "analysis/trajectory/plotVeloPCA.err"
    message:
        "[Trajectory analysis] Plot PCA and RNA velocity vectors"
    script:
        "../scripts/trajectory/plotVeloPCA.R"

rule plotVeloTSNE:
    input:
        rds = ["analysis/cell-cycle/addPerCellPhase.rds", "analysis/trajectory/scvelo.rds"]
    output:
        pdf = "analysis/trajectory/plotVeloTSNE.pdf"
    log:
        out = "analysis/trajectory/plotVeloTSNE.out",
        err = "analysis/trajectory/plotVeloTSNE.err"
    message:
        "[Trajectory analysis] Plot TSNE and RNA velocity vectors"
    script:
        "../scripts/trajectory/plotVeloTSNE.R"

rule plotVeloUMAP:
    input:
        rds = ["analysis/cell-cycle/addPerCellPhase.rds", "analysis/trajectory/scvelo.rds"]
    output:
        pdf = "analysis/trajectory/plotVeloUMAP.pdf"
    log:
        out = "analysis/trajectory/plotVeloUMAP.out",
        err = "analysis/trajectory/plotVeloUMAP.err"
    message:
        "[Trajectory analysis] Plot UMAP and RNA velocity vectors"
    script:
        "../scripts/trajectory/plotVeloUMAP.R"