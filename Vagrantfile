# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 st=2 et :

Vagrant.configure(2) do |config|
    config.vm.box = "debian/buster64"
    config.vm.box_check_update = false

    config.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.memory = "5096"
    end

    # Cluster nodes configuration && Provisionning
    5.times do |idx|
        config.vm.define "s#{idx}.infra" do |machine|
            machine.vm.hostname = "s#{idx}.infra"
            if idx == 0
                machine.vm.network "private_network",  ip: "192.168.50.#{10 * idx + 10}"
                machine.vm.network "forwarded_port", guest: 80, host: 1080
            else
                machine.vm.network "private_network",  ip: "192.168.50.#{10 * idx + 10}", auto_config: false
            end

            # Sync files between the host machine and the guests machines
            machine.vm.synced_folder "provision-files/", "/provision-files", type: "rsync" # Need to input the type
                                                                                            # else create an error about 'vboxsf'
            # Disable default folder syncing
            machine.vm.synced_folder ".", "/vagrant", disabled: true
            
            machine.vm.provision "shell", path: "provisionning/provision_install.sh"
            machine.vm.provision "shell", path: "provisionning/provision_authorize_keys.sh"
            machine.vm.provision "shell", path: "provisionning/provision_hosts.sh"
            if idx == 0
                machine.vm.provision "shell",
                  path: "provisionning/provision_dhcp.sh",
                  env: {"PERFORM_DHCLIENT" => "false"}
            else
                machine.vm.provision "shell",
                  path: "provisionning/provision_dhcp.sh",
                  env: {"PERFORM_DHCLIENT" => "true"}
            end
        end
    end

    # Configuration && provisionning server control
    config.vm.define "control" do |machine|
        machine.vm.hostname = "control"
        machine.vm.network "private_network", ip: "192.168.50.250"
        
        # Sync files between the host machine and the guests machines
        machine.vm.synced_folder "provision-files-ansible/", "/provision-files", type: "rsync"
        # Disable default folder syncing
        machine.vm.synced_folder ".", "/vagrant", disabled: true

        machine.vm.provision "shell", path: "provisionning/provision_install.sh"
        machine.vm.provision "shell", path: "provisionning/provision_ansible_install.sh"
        machine.vm.provision "shell", path: "provisionning/provision_authorize_keys.sh"
        machine.vm.provision "shell", path: "provisionning/provision_add_keys.sh"
        machine.vm.provision "shell", path: "provisionning/provision_hosts.sh"
        machine.vm.provision "shell", path: "provisionning/provision_dhcp.sh", env: {"PERFORM_DHCLIENT" => "false"}
        machine.vm.provision "shell", path: "provisionning/provision_ansible_playbook.sh"
    end
end
