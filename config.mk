# allocation for sbatch
ALLOCATION ?= COVID19-Portal
# partition (AKA queue) for sbatch
PARTITION ?= rtx-dev
# Time limit (minutes) for sbatch
TIME_MINUTES ?= 60
# environment variables that are set before starting container
DOTENV ?= ./dotenv/work2cache.env
# Docker image
IMAGE ?= enho/deeplabcut:2.1.10
# path to which Docker image will be pulled
SIF ?= ./dlc_2_1_10.sif
# where to mount the root of JupyterHub file expolorer (current working dir by default)
WD ?= $$PWD
