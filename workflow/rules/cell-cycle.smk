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