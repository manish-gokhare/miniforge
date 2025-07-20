#!/bin/bash

set -e  # Exit immediately on any error

# Define install path (shared system-wide)
INSTALL_PATH="/opt/miniforge"

# Download Miniforge installer if not already present
if [ ! -f Miniforge3-Linux-x86_64.sh ]; then
    echo "Downloading Miniforge..."
    curl -LO https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
fi

# Install or update Miniforge in /opt
if [ -d "$INSTALL_PATH" ]; then
    echo "Miniforge already installed. Updating..."
    sudo bash Miniforge3-Linux-x86_64.sh -b -u -p "$INSTALL_PATH"
else
    echo "Installing Miniforge..."
    sudo bash Miniforge3-Linux-x86_64.sh -b -p "$INSTALL_PATH"
fi

# Set PATH and source conda
export PATH="$INSTALL_PATH/bin:$PATH"
source "$INSTALL_PATH/etc/profile.d/conda.sh"

# Make sure /opt/miniforge is accessible to all users
echo "Setting permissions for shared access..."
sudo chmod -R o+rx "$INSTALL_PATH"

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

# Create or update the Conda environment
if conda info --envs | grep -qE "^\s*myenvs\s"; then
    echo "Environment 'myenvs' already exists. Updating..."
    conda env update -f environment.yml --prune
else
    echo "Creating environment 'myenvs'..."
    conda env create -f environment.yml
fi

# Activate environment
conda activate myenvs

# Register the kernel system-wide
echo "Registering Jupyter kernel system-wide..."
python -m ipykernel install --name "myenvs" --display-name "Python (myenvs)" --sys-prefix 

# Copy /opt/miniforge/envs/myenvs/share/jupyter/kernels/myenvs to jupyter share space.

mkdir -p /usr/share/jupyter/kernels
cp -r /opt/miniforge/envs/myenvs/share/jupyter/kernels/myenvs /usr/share/jupyter/kernels/

# Make directory readable and traversable by all
sudo chmod -R 755 /usr/share/jupyter/kernels/myenvs

# Just to be sure, ensure ownership by root (optional if already so)
sudo chown -R root:root /usr/share/jupyter/kernels/myenvs


# Display installed packages for verification
echo "Installed packages in 'myenvs':"
conda list | grep -E 'jupyter|python|kernel|proxy'
