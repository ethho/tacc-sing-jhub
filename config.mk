ALLOCATION ?= SD2E-Community # allocation for sbatch
PARTITION ?= gtx # partition (AKA queue) for sbatch
DOTENV ?= ./dotenv/work2cache.env # environment variables set outside container
IMAGE ?= sd2e/tacc-ml-jupyter:centos7-cuda10-tf2.2-pt1.7 # Docker image
SIF ?= ./tacc-ml.sif # path to which Docker image will be pulled
