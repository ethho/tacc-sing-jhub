PYTHON ?= python3
IMAGE ?= tacc/tacc-ml:centos7-cuda10-tf2.1-pt1.3
ALLOCATION ?= SD2E-Community
CONDA_ENV ?= envs/tf2_2.yaml
SIF ?= ./tacc-ml.sif