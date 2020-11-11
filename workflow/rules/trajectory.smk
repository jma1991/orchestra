# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule scvelo:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/trajectory/scvelo.rds"
    log:
        out = "analysis/trajectory/scvelo.out",
        err = "analysis/trajectory/scvelo.err"
    script:
        "../scripts/trajectory/scvelo.R"

rule plotVelo:
    input:
        rds = ["analysis/clustering/colLabels.rds", "analysis/trajectory/scvelo.rds"]
    output:
        pdf = "analysis/trajectory/plotVelo.pdf"
    log:
        out = "analysis/trajectory/plotVelo.out",
        err = "analysis/trajectory/plotVelo.err"
    script:
        "../scripts/trajectory/plotVelo.R"