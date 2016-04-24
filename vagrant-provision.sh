#!/usr/bin/env bash

# For trusty64


# General

Status () {
	$1 && echo [OK] $2 >> /tmp/status.txt || echo [Failure] $2 >> /tmp/status.txt
}

Status 'sudo apt-get update' 'Apt-get Update'
Status 'sudo apt-get -y upgrade' 'Apt-get Upgrade'


echo '
cd /vagrant/
echo "
===============================================

Essential commands:

npm run sw: Start the server + watchers
npm run x: Stop the server + watchers

See package.json for more commands

===============================================

"
' >> /home/vagrant/.bashrc


# Python / Pip

# Status 'sudo apt-get install -y python3-pip' 'Python & Pip'

# Status 'sudo pip3 install pystache' 'Pystache'
# Status 'sudo pip3 install pyyaml' 'PyYaml'


# Node

curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

Status 'sudo apt-get install -y nodejs' 'Node'
Status 'sudo apt-get install -y build-essential' 'Build Essential (Node)'

# Windows specific fix for NPM

# NPM can't create symlinks in the synced folder since Windows doesn't
# support symlinks, so we move the node_modules folder to an other location
# outside of the synced folder and create a symlink to that location.

# You have to run Git Bash as administrator on Windows too.

printf "HOST_OS=%s\n" $host_os >> /home/vagrant/.bashrc
if [ $host_os = 'Windows' ]; then
    rm -rf /vagrant/node_modules
    mkdir /home/vagrant/windows_fix_node_modules
    Status 'ln -s /home/vagrant/windows_fix_node_modules /vagrant/node_modules' 'Windows Host NPM Fix'
fi

cd /vagrant/

Status 'npm install' 'NPM Install'

echo '
Status:
'
cat /tmp/status.txt
echo '
============================================

Remember to run: vagrant ssh (or "vs" alias)

============================================
'
