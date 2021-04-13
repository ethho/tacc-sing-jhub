DOTENV ?= ./work2cache.env
PYTHON ?= python3
IMAGE ?= sd2e/tacc-ml-jupyter:centos7-cuda10-tf2.2-pt1.7
ALLOCATION ?= SD2E-Community
CONDA_ENV ?= envs/tf2_2.yaml
SIF ?= ./tacc-ml.sif
