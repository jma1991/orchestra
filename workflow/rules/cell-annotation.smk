# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule MouseGastrulationData:
    output:
        rds = "analysis/cell-anotation/MouseGastrulationData.rds"
    params:
        stage = ""
    script:
        "../cell-annotation/MouseGastrulationData.R"

rule trainSingleR:
    input:
        rds = "analysis/cell-annotation/MouseGastrulationData.rds"
    output:
        rds = "analysis/cell-annotation/trainSingleR.rds"
    params:
        batch = "batch",
        label = "celltype"
    script:
        "../cell-annotation/trainSingleR.R"

rule classifySingleR:
    input:
        rds = ["", ""]
    output:
        rds = "analysis/cell-annotation/classifySingleR.rds"
    script:
        "../cell-annotation/classifySingleR.R"