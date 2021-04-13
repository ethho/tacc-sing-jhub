include config.mk

# ------------------------------- Sanity checks -------------------------------

PROGRAMS := git docker $(PYTHON) singularity tox
.PHONY: $(PROGRAMS)
.SILENT: $(PROGRAMS)

docker:
	docker info 1> /dev/null 2> /dev/null && \
	if [ ! $$? -eq 0 ]; then \
		echo "\n[ERROR] Could not communicate with docker daemon. You may need to run with sudo.\n"; \
		exit 1; \
	fi
$(PYTHON) poetry singularity:
	$@ -h &> /dev/null; \
	if [ ! $$? -eq 0 ]; then \
		echo "[ERROR] $@ does not seem to be on your path. Please install $@"; \
		exit 1; \
	fi
tox:
	$@ -h &> /dev/null; \
	if [ ! $$? -eq 0 ]; then \
		echo "[ERROR] $@ does not seem to be on your path. Please pip install $@"; \
		exit 1; \
	fi
git:
	$@ -h &> /dev/null; \
	if [ ! $$? -eq 129 ]; then \
		echo "[ERROR] $@ does not seem to be on your path. Please install $@"; \
		exit 1; \
	fi

# -----------------------------------------------------------------------------

$(SIF):
	# Pulling singularity image from docker://$(IMAGE)
	# Please ensure that you are running this command from an idev session.
	singularity pull $@ docker://$(IMAGE)

$(DOTENV):
	touch $@

sif: $(SIF)

sing-shell: $(SIF) | singularity
	singularity shell --nv --home $$PWD $(SIF)

jupyter-%: $(DOTENV)
	@[ -f scripts/$@.sh ] || (echo "ERROR: could not find script at scripts/$@.sh" && exit 1)
	sbatch -A $(ALLOCATION) -p $(PARTITION) scripts/$@.sh \
		-i $(SIF) -e $(DOTENV) -- jupyter-notebook
	echo '' > jupyter.out
	tail -f jupyter.out
