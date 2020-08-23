# Speeding up MacOS Docker Development, by using an Ubuntu VM w/Docker & Docker Compose

MacOS is [slow](https://stackoverflow.com/questions/55951014/docker-in-macos-is-very-slow/55953023#55953023) at running Docker. It's a known  [issue](https://github.com/docker/for-mac/issues/77). There are [workarounds](https://engageinteractive.co.uk/blog/making-docker-faster-on-mac) that can be used. Even with them, it's not as fast as when we run Docker directly on a Linux system. 

In fact, running a Linux VM on your Mac and then using that VM to run Docker, is significantly [faster](./benchmarks.md) than just running Docker on your mac. This repo was made for that very reason. And becuase of my frustration as a result.

You can use this repo to quickly scaffold an Ubuntu box, with Docker & Docker Compose pre-installed. 

> Note: There are probably other, even better approaches to this, such as [provisioning docker](https://www.vagrantup.com/docs/provisioning/docker) or [vagrant-docker-compose](https://github.com/leighmcculloch/vagrant-docker-compose). But my goal here was to create a solution from scratch and learn more about the nuances of everything in the process. 

# Prerequisites

[VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html) must be installed.

# Development

Common commands for working with your box.

```bash
# starting 
vagrant up

# restarting
vagrant reload

# stopping
vagrant halt

# ssh inside
vagrant ssh
```

# Customization

## VagrantFile
Editing the Vagrantfile currently allows for the following

- Specify the IP address you'll use to access your box
- Specify resources to allocate for your box
- Mount folders from your machine into the box. For example: mount the directory where your Docker container is located. Then, you can ssh into your box and start the container.

## customize&#46;sh

This file is run during provisioning of your box. Which happens when you first run `vagrant up`, or explicitly re-provision, as mentioned [here](https://www.vagrantup.com/docs/provisioning#when-provisioning-happens).

This bash file currently is used to install software, such as Docker & Docker compose. Feel free to customize it to your liking.

# "Gotchas"

There are a few [gotchas](https://en.wikipedia.org/wiki/Gotcha_(programming)) when using this approach. 

## Permission issues when mounting volumes

When mounting volumes from MacOS to your VM, you may experience permission issues when your app attempts to make file writes. For example, you can experience this issue within a MySQL database container. This issue occurs when your data directory is mounted from MacOS to your Box, then from your Box to your Docker Container. You can see the issue described in more detail [here](https://stackoverflow.com/questions/34031397/running-docker-on-ubuntu-mounted-host-volume-is-not-writable-from-container).

In short, the workaround includes setting your Docker UID to be the same as the UID on the host (IE: your MacOS). 

To do this, first identify the UID on your host

```bash
# run this on your host machine. for example: macOS
id -u
```

Update Docker to use the UID from your host machine. For example, in docker-compose.yml:

```yml
db:
  image: mysql
  user: "501" # UID from host
```

Additionally, you may need to use the `nfs` type for your synced folder. For example, in Vagrantfile

```
  config.vm.synced_folder "~/MyApps/MyContainer", "/home/vagrant/MyContainer", type: "nfs"
```

# Additional

- [Benchmarks](./benchmarks.md)

# Todo

- [ ] Make VagrantFile config options load from a YML file, for a better workflow & easy scaffolding
- [ ] Create a way for others to benchmark and understand the major performance benefits documented in [benchmarks.md](./benchmarks.md)
