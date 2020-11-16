# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule cyclins:
    input:
        rds = "analysis/doublet-detection/mockDoubletSCE.rds"
    output:
        pdf = "analysis/cell-cycle/cyclins.pdf"
    params:
        pattern = "^Ccn[abde][0-9]$",
        size = 100
    log:
        out = "analysis/cell-cycle/cyclins.out",
        err = "analysis/cell-cycle/cyclins.err"
    message:
        "[Cell cycle assignment] Plot expression of cyclins"
    script:
        "../scripts/cell-cycle/cyclins.R"

rule cyclone:
    input:
        rds = "analysis/doublet-detection/mockDoubletSCE.rds"
    output:
        rds = "analysis/cell-cycle/cyclone.rds"
    params:
        rds = "mouse_cycle_markers.rds"
    log:
        out = "analysis/cell-cycle/cyclone.out",
        err = "analysis/cell-cycle/cyclone.err"
    message:
        "[Cell cycle assignment] Classify cells into cell cycle phases"
    threads:
        16
    script:
        "../scripts/cell-cycle/cyclone.R"

rule addPerCellPhase:
    input:
        rds = ["analysis/doublet-detection/mockDoubletSCE.rds", "analysis/cell-cycle/cyclone.rds"]
    output:
        rds = "analysis/cell-cycle/addPerCellPhase.rds"
    log:
        out = "analysis/cell-cycle/addPerCellPhase.out",
        err = "analysis/cell-cycle/addPerCellPhase.err"
    message:
        "[Cell cycle assignment] Add CC metrics to a SingleCellExperiment"
    script:
        "../scripts/cell-cycle/addPerCellPhase.R"

rule plotCyclone:
    input:
        rds = "analysis/cell-cycle/cyclone.rds"
    output:
        pdf = "analysis/cell-cycle/plotCyclone.pdf"
    log:
        out = "analysis/cell-cycle/plotCyclone.out",
        err = "analysis/cell-cycle/plotCyclone.err"
    message:
        "[Cell cycle assignment]"
    script:
        "../scripts/cell-cycle/plotCyclone.R"

rule plotPhaseSina:
    input:
        rds = "analysis/cell-cycle/addPerCellPhase.rds"
    output:
        pdf = "analysis/cell-cycle/plotPhaseSina.pdf"
    log:
        out = "analysis/cell-cycle/plotPhaseSina.out",
        err = "analysis/cell-cycle/plotPhaseSina.err"
    message:
        "[Doublet detection] Plot cell-cycle phase by cluster"
    script:
        "../scripts/cell-cycle/plotPhaseSina.R"

rule plotPhasePCA:
    input:
        rds = "analysis/cell-cycle/addPerCellPhase.rds"
    output:
        pdf = "analysis/cell-cycle/plotPhasePCA.pdf"
    log:
        out = "analysis/cell-cycle/plotPhasePCA.out",
        err = "analysis/cell-cycle/plotPhasePCA.err"
    message:
        "[Cell cycle assignment] Plot PCA coloured by cell-cycle phase"
    script:
        "../scripts/cell-cycle/plotPhasePCA.R"

rule plotPhaseTSNE:
    input:
        rds = "analysis/cell-cycle/addPerCellPhase.rds"
    output:
        pdf = "analysis/cell-cycle/plotPhaseTSNE.pdf"
    log:
        out = "analysis/cell-cycle/plotPhaseTSNE.out",
        err = "analysis/cell-cycle/plotPhaseTSNE.err"
    message:
        "[Cell cycle assignment] Plot TSNE coloured by cell-cycle phase"
    script:
        "../scripts/cell-cycle/plotPhaseTSNE.R"

rule plotPhaseUMAP:
    input:
        rds = "analysis/cell-cycle/addPerCellPhase.rds"
    output:
        pdf = "analysis/cell-cycle/plotPhaseUMAP.pdf"
    log:
        out = "analysis/cell-cycle/plotPhaseUMAP.out",
        err = "analysis/cell-cycle/plotPhaseUMAP.err"
    message:
        "[Cell cycle assignment] Plot UMAP coloured by cell-cycle phase"
    script:
        "../scripts/cell-cycle/plotPhaseUMAP.R"