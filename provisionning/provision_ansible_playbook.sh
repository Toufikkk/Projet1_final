#!/bin/sh

set -e
set -u

HOSTNAME="$(hostname)"
VAGRANT_HOME="/home/vagrant"
ROOT_HOME="/root"
SYNC_FOLDER="/provision-files"

export DEBIAN_FRONTEND=noninteractive

mkdir -p $VAGRANT_HOME/src
cp -R $SYNC_FOLDER/src/ $VAGRANT_HOME/ || :
chown -R vagrant:vagrant $VAGRANT_HOME/src/

cd $VAGRANT_HOME/src/ansible
su vagrant -c "ansible-playbook -i inventories/cluster.yml install-dns.yml"
su vagrant -c "ansible-playbook -i inventories/cluster.yml install-haproxy.yml"
su vagrant -c "ansible-playbook -i inventories/cluster.yml install-nfs.yml"
su vagrant -c "ansible-playbook -i inventories/cluster.yml install-mariadb.yml"
su vagrant -c "ansible-playbook -i inventories/cluster.yml install-apache.yml"

echo "SUCCESS ! ANSIBLE PLAYBOOK READING: DONE."
