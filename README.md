# miniforge installation

Installation script for conda  - miniforge.sh

#Run Script

chmod +x miniforge.sh

./miniforge.sh

# To activate conda shell use 
source /opt/miniforge/etc/profile.d/conda.sh 

# To activate myenvs environment
conda active myenvs # It ends up in myenvs shell

# To deactivate the runnign environment
conda deactivate

#To Test

sudo -u danny -i

export PATH=/opt/miniforge/bin:\$PATH

source /opt/miniforge/etc/profile.d/conda.sh

jupyter kernelspec list

