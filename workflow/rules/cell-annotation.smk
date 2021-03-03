# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

# SingleR 

rule classifySingleR:
    input:
        rds = ["results/cell-cycle/addPerCellPhase.rds", "resources/references/trainSingleR.rds"]
    output:
        rds = "results/cell-annotation/classifySingleR.rds"
    log:
        out = "results/cell-annotation/classifySingleR.out",
        err = "results/cell-annotation/classifySingleR.err"
    message:
        "[Cell type annotation] Classify cells with SingleR"
    threads:
        4
    script:
        "../scripts/cell-annotation/classifySingleR.R"

rule plotScoreHeatmap:
    input:
        rds = "results/cell-annotation/classifySingleR.rds"
    output:
        pdf = "results/cell-annotation/plotScoreHeatmap.pdf"
    log:
        out = "results/cell-annotation/plotScoreHeatmap.out",
        err = "results/cell-annotation/plotScoreHeatmap.err"
    message:
        "[Cell type annotation] Plot a score heatmap"
    script:
        "../scripts/cell-annotation/plotScoreHeatmap.R"

rule buildRankings:
    input:
        rds = "results/cell-cycle/addPerCellPhase.rds"
    output:
        rds = "results/cell-annotation/buildRankings.rds"
    log:
        out = "results/cell-annotation/buildRankings.out",
        err = "results/cell-annotation/buildRankings.err"
    message:
        "[Cell type annotation] Build gene expression rankings for each cell"
    script:
        "../scripts/cell-annotation/buildRankings.R"

rule calcAUC:
    input:
        tsv = "config/markers.tsv",
        rds = "results/cell-annotation/buildRankings.rds"
    output:
        rds = "results/cell-annotation/calcAUC.rds"
    log:
        out = "results/cell-annotation/buildRankings.out",
        err = "results/cell-annotation/buildRankings.err"
    message:
        "[Cell type annotation] Calculate AUC"
    script:
        "../scripts/cell-annotation/calcAUC.R"

rule exploreThresholds:
    input:
        rds = "results/cell-annotation/calcAUC.rds"
    output:
        pdf = "results/cell-annotation/exploreThresholds.pdf"
    log:
        out = "results/cell-annotation/exploreThresholds.out",
        err = "results/cell-annotation/exploreThresholds.err"
    message:
        "[Cell type annotation] Plot AUC histograms"
    script:
        "../scripts/cell-annotation/exploreThresholds.R"

rule addCelltype:
    input:
        rds = ["results/cell-cycle/addPerCellPhase.rds", "results/cell-annotation/calcAUC.rds"]
    output:
        rds = "results/cell-annotation/addCelltype.rds"
    log:
        out = "results/cell-annotation/addCelltype.out",
        err = "results/cell-annotation/addCelltype.err"
    message:
        "[Cell type annotation] Add celltype annotation"
    script:
        "../scripts/cell-annotation/addCelltype.R"

# GENE SETS

# GENE SET ACTIVITY

rule GOALL:
    input:
        rds = "results/cell-cycle/addPerCellPhase.rds"
    output:
        rds = "results/cell-annotation/GOALL.rds"
    params:
        species = "Hs"
    log:
        out = "results/cell-annotation/GOALL.out",
        err = "results/cell-annotation/GOALL.err"
    script:
        "../scripts/cell-annotation/GOALL.R"

rule sumCountsAcrossFeatures:
    input:
        rds = "results/cell-cycle/addPerCellPhase.rds"
    output:
        rds = "results/cell-annotation/sumCountsAcrossFeatures.rds"
    log:
        out = "results/cell-annotation/sumCountsAcrossFeatures.out",
        err = "results/cell-annotation/sumCountsAcrossFeatures.err"
    script:
        "../scripts/cell-annotation/sumCountsAcrossFeatures.R"
