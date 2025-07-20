source /opt/miniforge/etc/profile.d/conda.sh
conda activate myenvs
which jupyterhub

mkdir -p /etc/jupyterhub
cd /etc/jupyterhub

# Generate default config
/opt/miniforge/envs/myenvs/bin/jupyterhub --generate-config 



#Add below in /etc/jupyterhub/

sudo vi /etc/jupyterhub/jupyterhub_config.py

c.JupyterHub.bind_url = 'http://:8000'  # Or set to your IP:port
c.Authenticator.class_ = 'jupyterhub.auth.PAMAuthenticator'
c.Spawner.default_url = '/lab'  # Optional: default to JupyterLab if installed
c.Spawner.cmd = ['/opt/miniforge/envs/myenvs/bin/jupyter-labhub']

# Test PAM authentication
source /opt/miniforge/etc/profile.d/conda.sh
conda activate myenvs
/opt/miniforge/envs/myenvs/bin/jupyterhub -f /etc/jupyterhub/jupyterhub_config.py

#Loginto Jupyterhub 
<externalIP>:8000





