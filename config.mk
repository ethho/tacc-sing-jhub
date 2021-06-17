# allocation for sbatch
ALLOCATION ?= COVID19-Portal
# partition (AKA queue) for sbatch
PARTITION ?= rtx-dev
# Time limit (minutes) for sbatch
TIME_MINUTES ?= 60
# environment variables that are set before starting container
DOTENV ?= ./dotenv/work2cache.env
# Docker image
IMAGE ?= sd2e/tacc-ml-jupyter:centos7-cuda10-tf2.2-pt1.7
# path to which Docker image will be pulled
SIF ?= ./my_image.sif