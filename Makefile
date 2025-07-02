# Makefile -------------------------------------------------
# How to run:
# # one-time setup or whenever the lists change
# make dependencies
# # force a clean reinstall
# make clean-dependencies && make dependencies

.PHONY: dependencies dependencies-apt dependencies-pip clean-dependencies

# Top-level target: just run `make dependencies`
dependencies: dependencies-apt dependencies-pip
	@echo "All dependencies installed ✔"

# ----- APT ------------------------------------------------
APT_LIST := $(shell cat dependencies/apt.txt)
# Stamp file prevents re-running every time
.deps-apt-stamp: dependencies/apt.txt
	sudo apt-get update
	sudo xargs -a $< apt-get install -y --no-install-recommends
	touch $@

dependencies-apt: .deps-apt-stamp

# ----- PIP ------------------------------------------------
# PIP_LIST := deps/pip.txt
# .deps-pip-stamp: $(PIP_LIST)
# 	pip install --upgrade -r $(PIP_LIST)
# 	touch $@

# deps-pip: .deps-pip-stamp

# Optionally wipe the stamps so “make deps” reinstalls
clean-dependencies:
	rm -f .deps-*-stamp
