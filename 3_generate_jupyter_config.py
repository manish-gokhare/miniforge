source /opt/miniforge/etc/profile.d/conda.sh
conda activate myenvs
which jupyterhub

mkdir -p /etc/jupyterhub
cd /etc/jupyterhub

# Generate default config
/opt/miniforge/envs/myenvs/bin/jupyterhub --generate-config

