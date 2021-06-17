# tacc-sing-jhub

Launches a JupyterHub instance on TACC HPC in a Singularity container.

**NOTE**: If your workflow is I/O intensive, please be sure to locate your working directory on the appropriate file system. Please see the [TACC documentation](https://portal.tacc.utexas.edu/tutorials/managingio) for details.

## Usage

1. From a login node, clone this repo and cd to root of this repo
```bash
git clone git@github.com:eho-tacc/tacc-sing-jhub.git tacc-sing-jhub

# alternatively, clone one of the application-specific branches, for instance DeepLabCut
git clone --single-branch --branch dlc git@github.com:eho-tacc/tacc-sing-jhub.git tacc-sing-jhub

cd tacc-sing-jhub
```
2. Configure environment by editing [`config.mk`](./config.mk)
    - `ALLOCATION` and `PARTITION` are passed to `sbatch` command as `-A` and `-p` options respectively. See `man sbatch` for details.
    - `DOTENV` is a path to an env-formatted file. It contains variables that will be exported _before_ launching the Singularity container.
        - To set environment variables _within_ the container, prefix variable names in the `DOTENV` with `SINGULARITYENV_`.
        - For instance, to set the variable `SHELL` within the container:
        ```bash
        # my_env.env
        SINGULARITYENV_SHELL=/bin/bash
        ```
        - [`dotenv/work2cache.env`](dotenv/work2cache.env) is an example that installs python packages on /work2
    - Singularity will pull the Docker `IMAGE` to POSIX path `SIF`.
        - For instance, the following `config.mk` will `singularity pull ./my_image.sif docker://docker/whalesay:latest`:
        ```bash
        IMAGE ?= docker/whalesay:latest 
        SIF ?= ./my_image.sif 
        ```
        - The Docker `IMAGE` _must_ have the binary `jupyter-notebook` in its `$PATH`
    - Any of these variables can be overwritten when running `make` commands. 
        - For instance, to overwrite `PARTITION`:
        ```bash
        PARTITION="p100" make jupyter-mav2
        ```
        - See [GNU Make](https://www.gnu.org/software/make/) documentation for details.
3. **Optional**: manually pull Singularity image
    1. Enter `idev` session
    2. Pull image from Dockerhub to `.sif` file
    ```bash
    module load tacc-singularity
    make sif
    ```
    3. Exit `idev` session
5. Submit job via `sbatch`, using `make jupyter-frontera` or `make jupyter-mav2`:
```bash
$ make jupyter-frontera
...
tail -f jupyter.out

job 2822590 execution at: Tue Apr 13 14:35:22 CDT 2021
TACC: running on node c196-012
TACC: using DOTENV=work2cache.env
SINGULARITYENV_PYTHONUSERBASE=/work2/06634/eho/jupyter_packages
SINGULARITYENV_JUPYTER_PATH=/work2/06634/eho/jupyter_packages/share/jupyter:
SINGULARITYENV_JUPYTER_WORK=/work2/06634/eho/jupyter_packages
TACC: using singularity version 3.6.3-2.el7
TACC: using IPYTHON_BIN singularity exec --nv --home /work2/06634/eho/support/tacc-sing-jhub --bind /work2 ./tacc-ml.sif jupyter-notebook
TACC: using jupyter command: singularity exec --nv --home /work2/06634/eho/support/tacc-sing-jhub --bind /work2 ./tacc-ml.sif jupyter-notebook --config=/home1/00832/envision/tacc-tvp/server/scripts/frontera/jupyter.tvp.config.py
TACC: got login node jupyter port 11296
TACC: created reverse ports on Frontera logins
Your jupyter notebook server is now running!
Please point your favorite web browser to https://vis.tacc.utexas.edu:11296/?token=53ba17ctokengoeshere3b5ef243aa
```
6. Check the job output file `./jupyter.out` for URL to JupyterHub, or for errors

## Troubleshooting

_WIP_

- Check `$HOME/.jupyter/${NODE}.log` for additional debugging logs. The `$NODE` is the compute node that the job is running on; you can retrieve it using the `squeue` command.