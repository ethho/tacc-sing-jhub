FROM tacc/tacc-ml:centos7-cuda10-tf2.1-pt1.3
RUN conda update -n base -c defaults conda

ARG CONDA_ENV
COPY ${CONDA_ENV} /tmp/conda_envs/env.yaml
RUN conda env update -n=base -f=/tmp/conda_envs/env.yaml


