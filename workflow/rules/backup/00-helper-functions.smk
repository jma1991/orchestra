from snakemake.utils import validate
import pandas as pd

singularity: "docker://continuumio/miniconda3"

# Validate workflow configuration
configfile: "config/config.yaml"
validate(config, schema = "../schemas/config.schema.yaml")

# Validate sample information
samples = pd.read_table(config["samples"])
samples = samples.set_index("SM", drop = False)
validate(samples, schema = "schemas/samples.schema.yaml")

# Validate unit information
units = pd.read_table(config["units"])
units = units.set_index(["SM", "ID"], drop = False)
validate(units, schema = "schemas/units.schema.yaml")

# Wildcard constratins
wildcard_constraints:
    sample = "|".join(samples.index),
    unit = "|".join(units.index)

# Helper functions
