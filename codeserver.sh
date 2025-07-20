#!/bin/bash

# Source the Miniforge conda.sh script
source /opt/miniforge/etc/profile.d/conda.sh

# Activate your environment
conda activate myenvs

# Install code-server using npm
npm install -g code-server

code-server --auth none --port 8888 --bind-addr 0.0.0.0:8888 --disable-telemetry

<externalIP>:8888

