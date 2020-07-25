# Cell annotation

rule multiBatchNorm:
    input:
        rds = lambda wildcards: expand("results//{sample}.rds", sample = samples.loc[])
    output:
        rds = lambda wildcards: expand("results//{sample}.rds", sample = samples.loc[])
    script:
        "multiBatchNorm.R"

rule combineVar:
    input:
        rds = lambda wildcards: expand("results//{sample}.rds", sample = samples.loc[])
    output:
        rds = "results/{group}.combineVar.rds"
    script:
        "combineVar.R"

rule correctExperiments:
    input:
        sce = lambda wildcards: expand("results//{sample}.rds", sample = samples.loc[])
    output:
        sce = "results/correct/{group}.rds"
    params:
        idx = 
    script:
        "correctExperiments.R"