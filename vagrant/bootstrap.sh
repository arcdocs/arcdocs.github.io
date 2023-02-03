#!/bin/bash

apt-get update
apt-get install git
wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
./miniconda.sh -b -p /home/vagrant/miniconda
# ensures conda loaded in shell
echo "source /home/vagrant/miniconda/etc/profile.d/conda.sh" >> /home/vagrant/.bashrc
source /home/vagrant/miniconda/etc/profile.d/conda.sh
chown -R vagrant:vagrant /home/vagrant/miniconda

# create environment and build book
cd /vagrant
conda env create -f environment.yml
conda activate arcdocs-jb
jb clean book/
jb build book/
