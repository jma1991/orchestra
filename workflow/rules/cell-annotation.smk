# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule EmbryoAtlasData:
    output:
        rds = "analysis/cell-anotation/EmbryoAtlasData.rds"
    params:
        stage = [""]
    message:
        "[Cell type annotation] Retrieve Mouse gastrulation timecourse data"
    script:
        "../cell-annotation/EmbryoAtlasData.R"

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