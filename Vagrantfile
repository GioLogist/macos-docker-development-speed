configDir = $configDir ||= File.expand_path(".")

# Provision with customize script
customizeScriptPath = File.expand_path("./scripts/customize.sh")

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-19.10"

	if File.exists? customizeScriptPath then
		config.vm.provision "shell", path: customizeScriptPath
	end
end