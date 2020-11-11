# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule HclustParam:
    input:
        rds = "analysis/reduced-dimensions/selectPCA.rds"
    output:
        rds = "analysis/clustering/HclustParam.rds"
    log:
        out = "analysis/clustering/HclustParam.out",
        err = "analysis/clustering/HclustParam.err"
    script:
        "../scripts/clustering/HclustParam.R"

rule KmeansParam:
    input:
        rds = "analysis/reduced-dimensions/selectPCA.rds"
    output:
        rds = "analysis/clustering/KmeansParam.{centers}.rds"
    log:
        out = "analysis/clustering/KmeansParam.{centers}.out",
        err = "analysis/clustering/KmeansParam.{centers}.err"
    script:
        "../scripts/clustering/KmeansParam.R"

rule NNGraphParam:
    input:
        rds = "analysis/reduced-dimensions/selectPCA.rds"
    output:
        rds = "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.rds"
    log:
        out = "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.out",
        err = "analysis/clustering/NNGraphParam.{k}.{type}.{fun}.err"
    script:
        "../scripts/clustering/NNGraphParam.R"

rule colLabels:
    input:
        rds = ["analysis/reduced-dimensions/reducedDims.rds", "analysis/clustering/NNGraphParam.10.jaccard.louvain.rds"]
    output:
        rds = "analysis/clustering/colLabels.rds"
    log:
        out = "analysis/clustering/colLabels.out",
        err = "analysis/clustering/colLabels.err"
    script:
        "../scripts/clustering/colLabels.R"