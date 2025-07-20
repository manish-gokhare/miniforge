#!/bin/bash

# Define install path
INSTALL_PATH="$HOME/miniforge"

# Download Miniforge if not present
if [ ! -f Miniforge3-Linux-x86_64.sh ]; then
    echo "Downloading Miniforge..."
    curl -LO https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
fi

# Install or update Miniforge
if [ -d "$INSTALL_PATH" ]; then
    echo "Miniforge already installed. Updating..."
    bash Miniforge3-Linux-x86_64.sh -b -u -p "$INSTALL_PATH"
else
    echo "Installing Miniforge..."
    bash Miniforge3-Linux-x86_64.sh -b -p "$INSTALL_PATH"
fi

# Set PATH and source conda
export PATH="$INSTALL_PATH/bin:$PATH"
source "$INSTALL_PATH/etc/profile.d/conda.sh"

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
  - nodejs=18
  - configurable-http-proxy=4.5.4
EOF

# Update or create conda environment
if conda env list | grep -q "^myenvs"; then
    echo "Updating conda envs"
    conda env update -f environment.yml --prune
else
    echo "Creating environment 'myenvs'..."
    conda env create -f environment.yml
fi


# Activate environment and test
conda activate myenvs
echo "Installed packages:"
conda list | grep -E 'jupyter|python|kernel|proxy'
