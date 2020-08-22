configDir = $configDir ||= File.expand_path(".")

# Provision with customize script
customizeScriptPath = File.expand_path("./scripts/customize.sh")

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-19.10"
  config.vm.network :private_network, ip: "192.168.10.12"

	if File.exists? customizeScriptPath then
		config.vm.provision "shell", path: customizeScriptPath
	end

  # Resources
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  # Sync Folders
  # Edit & uncomment the lines below to enable
  # config.vm.synced_folder "LOCAL_DIR", "VAGRANT_DIR" # using default type from vagrant
  # config.vm.synced_folder "LOCAL_DIR", "VAGRANT_DIR", type: "nfs" # using nfs (can be faster on mac)
end