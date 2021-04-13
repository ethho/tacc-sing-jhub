include config.mk

$(SIF):
	# Pulling singularity image from docker://$(IMAGE)
	# Please ensure that you are running this command from an idev session.
	singularity pull $@ "docker://$(IMAGE)"

$(DOTENV):
	touch $@

sif: $(SIF)

sing-shell: $(SIF) 
	singularity shell --nv --home $$PWD $(SIF)

jupyter-%: $(DOTENV)
	@[ -f scripts/$@.sh ] || (echo "ERROR: could not find script at scripts/$@.sh" && exit 1)
	sbatch -A $(ALLOCATION) -p $(PARTITION) scripts/$@.sh \
		-i $(SIF) -e $(DOTENV) -u "docker://$(IMAGE)" -- jupyter-notebook
	echo '' > jupyter.out
	tail -f jupyter.out
