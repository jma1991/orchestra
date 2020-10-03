# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule findDoubletClusters:
    input:
        rds = ""
    output:
        rds = ""
    message:
        "[Doublet detection] Detect doublet clusters"
    script:
        "../scripts/04-feature-selection/modelGeneVar.R"


rule doubletCluster:
    input:
        rds = "{object}.rds"
    output:
        rds = "doubletCluster.rds"
    message:
        "[Doublet detection] Detect doublet clusters"
    script:
        "doubletCluster.R"

rule doubletCells:
    input:
        rds = "{object}.rds"
    output:
        rds = "doubletCells.rds"
    message:
        "[Doublet detection] Detect doublet cells"
    script:
        "doubletCells.R"
