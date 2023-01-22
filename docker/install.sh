#!/bin/bash
set -e

sudo apt-get -y update
sudo apt-get -y upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
	bash-completion \
	build-essential \
	curl \
	git \
	texlive-latex-extra \
	texlive-bibtex-extra \
	latexmk \
	python3-pip \
	python3-setuptools \
	python3-venv \
	unzip \
	wget \
	vim

python3 -m venv --prompt lgfr ~/.venv-lgfr
source ~/.venv-lgfr/bin/activate
pip3 install --no-cache-dir -r /tmp/requirements.txt


