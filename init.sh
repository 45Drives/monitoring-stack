#!/bin/bash

function get_base_distro() {
    local distro=$(cat /etc/os-release | grep '^ID_LIKE=' | head -1 | sed 's/ID_LIKE=//' | sed 's/"//g' | awk '{print $1}')

    if [ -z "$distro" ]; then
	    distro=$(cat /etc/os-release | grep '^ID=' | head -1 | sed 's/ID=//' | sed 's/"//g' | awk '{print $1}')
	fi

    echo $distro
}

function get_distro() {
	local distro=$(cat /etc/os-release | grep '^ID=' | head -1 | sed 's/ID=//' | sed 's/"//g' | awk '{print $1}')

    echo $distro
}

function get_version_id() {
	local version_id=$(cat /etc/os-release | grep '^VERSION_ID=' | head -1 | sed 's/VERSION_ID=//' | sed 's/"//g' | awk '{print $1}' | awk 'BEGIN {FS="."} {print $1}')

    echo $version_id
}

base_distro=$(get_base_distro)
distro=$(get_distro)
distro_version=$(get_version_id)

# Install ansible from ansible ppa if ubuntu 22
if [ "$distro" == "ubuntu" ] && [ $distro_version -eq 22 ];then
    echo "Installing ansible ppa..." 
    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    echo "Installing ansible..."
    sudo apt install ansible -y
fi

# Initialize ansible varibles and inventory
cp group_vars/metrics.yml.sample group_vars/metrics.yml
cp group_vars/exporters.yml.sample group_vars/exporters.yml
cp hosts.sample hosts
