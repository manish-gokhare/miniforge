#!/bin/bash

# Source the Miniforge conda.sh script
source /opt/miniforge/etc/profile.d/conda.sh

# Activate your environment
conda activate myenvs

# Install code-server using npm
npm install -g code-server

