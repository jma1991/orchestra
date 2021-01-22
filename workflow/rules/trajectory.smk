# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule perCellEntropy:
    input:
        rds = "results/cell-cycle/addPerCellPhase.rds"
    output:
        rds = "results/trajectory/perCellEntropy.rds"
    log:
        out = "results/trajectory/perCellEntropy.out",
        err = "results/trajectory/perCellEntropy.err"
    message:
        "[Trajectory results] Compute the per-cell entropy"
    script:
        "../scripts/trajectory/perCellEntropy.R"

rule plotEntropy:
    input:
        rds = ["results/cell-cycle/addPerCellPhase.rds", "results/trajectory/perCellEntropy.rds"]
    output:
        pdf = "results/trajectory/plotEntropy.pdf"
    log:
        out = "results/trajectory/plotEntropy.out",
        err = "results/trajectory/plotEntropy.err"
    message:
        "[Trajectory results] Plot the per-cell entropy"
    script:
        "../scripts/trajectory/plotEntropy.R"

rule slingshot:
    input:
        rds = "results/cell-cycle/addPerCellPhase.rds"
    output:
        rds = "results/trajectory/slingshot.rds"
    log:
        out = "results/trajectory/slingshot.out",
        err = "results/trajectory/slingshot.err"
    message:
        "[Trajectory results] Perform lineage inference with Slingshot"
    script:
        "../scripts/trajectory/slingshot.R"

rule plotCurves:
    input:
        rds = ["results/cell-cycle/addPerCellPhase.rds", "results/trajectory/slingshot.rds"]
    output:
        pdf = "results/trajectory/plotCurves.pdf"
    log:
        out = "results/trajectory/plotCurves.out",
        err = "results/trajectory/plotCurves.err"
    message:
        "[Trajectory results]"
    script:
        "../scripts/trajectory/plotCurves.R"

rule scvelo:
    input:
        rds = "results/cell-cycle/addPerCellPhase.rds"
    output:
        rds = "results/trajectory/scvelo.rds"
    log:
        out = "results/trajectory/scvelo.out",
        err = "results/trajectory/scvelo.err"
    message:
        "[Trajectory results] RNA velocity with scVelo"
    threads:
        4
    script:
        "../scripts/trajectory/scvelo.R"

rule embedVelocity:
    input:
        rds = ["results/cell-cycle/addPerCellPhase.rds", "results/trajectory/scvelo.rds"]
    output:
        rds = "results/trajectory/embedVelocity.{reducedDim}.rds"
    log:
        out = "results/trajectory/embedVelocity.{reducedDim}.out",
        err = "results/trajectory/embedVelocity.{reducedDim}.err"
    message:
        "[Trajectory results] Project velocities onto {wildcards.reducedDim} embedding"
    script:
        "../scripts/trajectory/embedVelocity.R"

rule gridVectors:
    input:
        rds = ["results/cell-cycle/addPerCellPhase.rds", "results/trajectory/embedVelocity.{reducedDim}.rds"]
    output:
        rds = "results/trajectory/gridVectors.{reducedDim}.rds"
    log:
        out = "results/trajectory/gridVectors.{reducedDim}.out",
        err = "results/trajectory/gridVectors.{reducedDim}.err"
    message:
        "[Trajectory results] Summarize {wildcards.reducedDim} vectors into a grid"
    script:
        "../scripts/trajectory/gridVectors.R"

rule plotVeloPCA:
    input:
        rds = ["results/cell-cycle/addPerCellPhase.rds", "results/trajectory/gridVectors.PCA.rds"]
    output:
        pdf = "results/trajectory/plotVeloPCA.pdf"
    log:
        out = "results/trajectory/plotVeloPCA.out",
        err = "results/trajectory/plotVeloPCA.err"
    message:
        "[Trajectory results] Plot PCA and RNA velocity vectors"
    script:
        "../scripts/trajectory/plotVeloPCA.R"

rule plotVeloTSNE:
    input:
        rds = ["results/cell-cycle/addPerCellPhase.rds", "results/trajectory/gridVectors.TSNE.rds"]
    output:
        pdf = "results/trajectory/plotVeloTSNE.pdf"
    log:
        out = "results/trajectory/plotVeloTSNE.out",
        err = "results/trajectory/plotVeloTSNE.err"
    message:
        "[Trajectory results] Plot TSNE and RNA velocity vectors"
    script:
        "../scripts/trajectory/plotVeloTSNE.R"

rule plotVeloUMAP:
    input:
        rds = ["results/cell-cycle/addPerCellPhase.rds", "results/trajectory/gridVectors.UMAP.rds"]
    output:
        pdf = "results/trajectory/plotVeloUMAP.pdf"
    log:
        out = "results/trajectory/plotVeloUMAP.out",
        err = "results/trajectory/plotVeloUMAP.err"
    message:
        "[Trajectory results] Plot UMAP and RNA velocity vectors"
    script:
        "../scripts/trajectory/plotVeloUMAP.R"