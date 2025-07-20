#!/bin/bash

# Download and install Miniforge
curl -LO https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
bash Miniforge3-Linux-x86_64.sh -b -p $HOME/miniforge

# Setup PATH
export PATH="$HOME/miniforge/bin:$PATH"
source $HOME/miniforge/etc/profile.d/conda.sh

# Create environment.yml
cat <<EOF > environment.yml
name: myenvs
channels:
  - conda-forge
dependencies:
  - python=3.9
  - jupyterhub
  - notebook
  - ipykernel
  - nodejs=18  # Use Node.js 18 LTS (compatible)
  - configurable-http-proxy=4.5.4  # Known compatible version

# Create conda environment
conda env create -f environment.yml

# Activate and test
conda activate myenvs
jupyter --version
