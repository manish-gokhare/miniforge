# miniforge installation

Installation script for conda  - miniforge.sh

#Run Script

chmod +x miniforge.sh

./miniforge.sh

#To Test

sudo -u danny -i
export PATH=/opt/miniforge/bin:\$PATH
source /opt/miniforge/etc/profile.d/conda.sh
jupyter kernelspec list
