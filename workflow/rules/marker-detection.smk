# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule pairwiseTTests:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.rds"
    log:
        out = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.out",
        err = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.err"
    message:
        "[Marker detection] Perform pairwise t-tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc})"
    threads:
        16
    script:
        "../scripts/marker-detection/pairwiseTTests.R"

rule combineTTests:
    input:
        rds = "analysis/marker-detection/pairwiseTTests.{direction}.{lfc}.rds"
    output:
        rds = "analysis/marker-detection/combineTTests.{direction}.{lfc}.{type}.rds"
    log:
        out = "analysis/marker-detection/combineTTests.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/combineTTests.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Combine pairwise t-tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    threads:
        16
    script:
        "../scripts/marker-detection/combineTTests.R"

rule writeTTests:
    input:
        rds = "analysis/marker-detection/combineTTests.{direction}.{lfc}.{type}.rds"
    output:
        dir = directory("analysis/marker-detection/writeTTests.{direction}.{lfc}.{type}")
    log:
        out = "analysis/marker-detection/writeTTests.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/writeTTests.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Write pairwise t-tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    script:
        "../scripts/marker-detection/writeTTests.R"

rule plotTTestsEffects:
    input:
        rds = "analysis/marker-detection/combineTTests.{direction}.{lfc}.{type}.rds"
    output:
        dir = directory("analysis/marker-detection/plotTTestsEffects.{direction}.{lfc}.{type}")
    log:
        out = "analysis/marker-detection/plotTTestsEffects.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/plotTTestsEffects.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Plot pairwise t-tests effect sizes (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    script:
        "../scripts/marker-detection/plotTTestsEffects.R"

rule heatmapTTests:
    input:
        rds = ["analysis/clustering/colLabels.rds", "analysis/marker-detection/combineTTests.{direction}.{lfc}.{type}.rds"]
    output:
        pdf = "analysis/marker-detection/heatmapTTests.{direction}.{lfc}.{type}.pdf"
    params:
        size = 100
    log:
        out = "analysis/marker-detection/heatmapTTests.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/heatmapTTests.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Plot heatmap of t-tests"
    script:
        "../scripts/marker-detection/heatmapTTests.R"

rule pairwiseWilcox:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/marker-detection/pairwiseWilcox.{direction}.{lfc}.rds"
    log:
        out = "analysis/marker-detection/pairwiseWilcox.{direction}.{lfc}.out",
        err = "analysis/marker-detection/pairwiseWilcox.{direction}.{lfc}.err"
    message:
        "[Marker detection] Perform pairwise Wilcoxon rank sum tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc})"
    threads:
        16
    script:
        "../scripts/marker-detection/pairwiseWilcox.R"

rule combineWilcox:
    input:
        rds = "analysis/marker-detection/pairwiseWilcox.{direction}.{lfc}.rds"
    output:
        rds = "analysis/marker-detection/combineWilcox.{direction}.{lfc}.{type}.rds"
    log:
        out = "analysis/marker-detection/combineWilcox.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/combineWilcox.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Combine pairwise Wilcoxon rank sum tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    threads:
        16
    script:
        "../scripts/marker-detection/combineWilcox.R"

rule writeWilcox:
    input:
        rds = "analysis/marker-detection/combineWilcox.{direction}.{lfc}.{type}.rds"
    output:
        dir = directory("analysis/marker-detection/writeWilcox.{direction}.{lfc}.{type}")
    log:
        out = "analysis/marker-detection/writeWilcox.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/writeWilcox.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Write pairwise Wilcoxon rank sum tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    script:
        "../scripts/marker-detection/writeWilcox.R"

rule plotWilcoxEffects:
    input:
        rds = "analysis/marker-detection/combineWilcox.{direction}.{lfc}.{type}.rds"
    output:
        dir = directory("analysis/marker-detection/plotWilcoxEffects.{direction}.{lfc}.{type}")
    log:
        out = "analysis/marker-detection/plotWilcoxEffects.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/plotWilcoxEffects.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Plot pairwise Wilcoxon effect sizes (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    script:
        "../scripts/marker-detection/plotWilcoxEffects.R"

rule heatmapWilcox:
    input:
        rds = ["analysis/clustering/colLabels.rds", "analysis/marker-detection/combineWilcox.{direction}.{lfc}.{type}.rds"]
    output:
        pdf = "analysis/marker-detection/heatmapWilcox.{direction}.{lfc}.{type}.pdf"
    params:
        size = 100
    log:
        out = "analysis/marker-detection/heatmapWilcox.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/heatmapWilcox.{direction}.{lfc}.{type}.err"
    script:
        "../scripts/marker-detection/heatmapWilcox.R"

rule pairwiseBinom:
    input:
        rds = "analysis/clustering/colLabels.rds"
    output:
        rds = "analysis/marker-detection/pairwiseBinom.{direction}.{lfc}.rds"
    log:
        out = "analysis/marker-detection/pairwiseBinom.{direction}.{lfc}.out",
        err = "analysis/marker-detection/pairwiseBinom.{direction}.{lfc}.err"
    message:
        "[Marker detection] Perform pairwise binomial tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc})"
    threads:
        16
    script:
        "../scripts/marker-detection/pairwiseBinom.R"

rule combineBinom:
    input:
        rds = "analysis/marker-detection/pairwiseBinom.{direction}.{lfc}.rds"
    output:
        rds = "analysis/marker-detection/combineBinom.{direction}.{lfc}.{type}.rds"
    log:
        out = "analysis/marker-detection/combineBinom.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/combineBinom.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Combine pairwise binomial tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    threads:
        16
    script:
        "../scripts/marker-detection/combineBinom.R"

rule writeBinom:
    input:
        rds = "analysis/marker-detection/combineBinom.{direction}.{lfc}.{type}.rds"
    output:
        dir = directory("analysis/marker-detection/writeBinom.{direction}.{lfc}.{type}")
    log:
        out = "analysis/marker-detection/writeBinom.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/writeBinom.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Write pairwise binomial tests (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    script:
        "../scripts/marker-detection/writeBinom.R"

rule plotBinomEffects:
    input:
        rds = "analysis/marker-detection/combineBinom.{direction}.{lfc}.{type}.rds"
    output:
        dir = directory("analysis/marker-detection/plotBinomEffects.{direction}.{lfc}.{type}")
    log:
        out = "analysis/marker-detection/plotBinomEffects.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/plotBinomEffects.{direction}.{lfc}.{type}.err"
    message:
        "[Marker detection] Plot pairwise binomial effect sizes (direction = '{wildcards.direction}', lfc = {wildcards.lfc}, pval.type = '{wildcards.type}')"
    script:
        "../scripts/marker-detection/plotBinomEffects.R"

rule heatmapBinom:
    input:
        rds = ["analysis/clustering/colLabels.rds", "analysis/marker-detection/combineBinom.{direction}.{lfc}.{type}.rds"]
    output:
        pdf = "analysis/marker-detection/heatmapBinom.{direction}.{lfc}.{type}.pdf"
    params:
        size = 100
    log:
        out = "analysis/marker-detection/heatmapBinom.{direction}.{lfc}.{type}.out",
        err = "analysis/marker-detection/heatmapBinom.{direction}.{lfc}.{type}.err"
    script:
        "../scripts/marker-detection/heatmapBinom.R"