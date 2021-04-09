# tacc-sing-jhub

Launches a Jupyterhub instance on TACC Maverick2 in a Singularity container.

**NOTE**: If your workflow is I/O intensive, please be sure to locate your working directory on the appropriate file system. Please see the [TACC documentation](https://portal.tacc.utexas.edu/tutorials/managingio) for details.

## Usage

1. Clone this repo and cd to root of this repo
2. Start idev session
3. Pull Singularity container
```bash
module load tacc-Singularity
make sif
```
4. Exit idev
5. Edit `ALLOCATION` in [`config.mk`](config.mk) as necessary
6. `make jupyter-mav2`
7. Check contents of `./jupyter.out` for URL to Jupyterhub, or for errors