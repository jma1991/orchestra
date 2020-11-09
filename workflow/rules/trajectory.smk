# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule scVelo:
    input:
        rds = ""
    output:
        rds = ""
    params:
        hvg = ""
    log:
        out = "analysis/trajectory/scVelo.out",
        err = "analysis/trajectory/scVelo.err"
    script:
        "../scripts/trajectory/scVelo.R"