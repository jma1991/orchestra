# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

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
