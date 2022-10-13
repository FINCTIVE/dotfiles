# debian server

## TODO

- [x] ARM support for [k8s tools setup scripts](https://github.com/FINCTIVE/dotfiles/blob/main/debian/setup_k8s_tools.sh)
- [x] ARM support for Docker container
- [x] interactive init script

## full tool set 

```
curl -L https://raw.githubusercontent.com/FINCTIVE/dotfiles/main/debian/init.sh | sh
```

## docker container

`finctive/playground`, [Dockerfile](https://github.com/FINCTIVE/dotfiles/blob/main/debian/Dockerfile)

- basic cli setup
- code-server
- k8s ops tools

## Vagrant VM(Deprecated)

### Expose kind cluster api-server to host

- copy `~/.kube/config` file from the VM to the host machine

- change server url to `https://localhost:8081` (port mapping)

  - **both on vm and host**, generated `0.0.0.0` is not reachable.
  
  - TODO: change local kubeconfig file to localhost

### How to use proxies

- Vagrant plugin [vagrant-proxyconf](https://github.com/tmatilai/vagrant-proxyconf)

- kind
  - **must** set proxy environment variables

    - which triggers kind to generate NO_PROXY values to avoid node container DNS names to use proxies

  - otherwise, if the only proxy settings is in the docker config file
  
    - service discovery between node containers is blocked by proxy settings

  - tip: view container env variables

    - `docker exec container-name env`

- manually

    ```
    HOST_IP="host-machine-lan-ip"
    PROXY_PORT="proxy-port"
    HOST_HTTP_PROXY="http://"$HOST_IP":"$PROXY_PORT
    echo $HOST_HTTP_PROXY
    export http_proxy=$HOST_HTTP_PROXY
    export https_proxy=$HOST_HTTP_PROXY
    export HTTP_PROXY=$HOST_HTTP_PROXY
    export HTTPS_PROXY=$HOST_HTTP_PROXY
    ```

### Default port mapping

- run `vagrant port` to view the full list

```
# equal to vagrant ssh
ssh vagrant@localhost -p 2222 -i .vagrant/machines/default/virtualbox/private_key
```

### Vagrantfile backup

```
Vagrant.configure("2") do |config|
  # Local Settings
  config.vm.provider "virtualbox" do |v|
    v.memory = 8000
    v.cpus = 3
  end
  
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = "http://proxy-ip:proxy-port/"
    config.proxy.https    = "https://proxy-ip:proxy-port/"
    config.proxy.no_proxy = "localhost,127.0.0.1,.example.com"
  end

  # code server
  config.vm.network "forwarded_port", guest: 4000, host: 4000
  # kind api-server
  config.vm.network "forwarded_port", guest: 4001, host: 4001
  # other
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8081, host: 8081
  config.vm.network "forwarded_port", guest: 8082, host: 8082

  # add new port: change the config, run `vagrant reload`

  # VM
  config.vm.box = "debian/bullseye64"
  # config.vm.provision "shell", path: "setup_docker.sh", privileged: false
  config.vm.provision "docker"
  config.vm.provision "shell", path: "setup_dev.sh", privileged: false
  config.vm.provision "shell", path: "setup_go.sh", privileged: false
  config.vm.provision "shell", path: "setup_code_server.sh", privileged: false
  config.vm.provision "shell", path: "setup_k8s_tools.sh", privileged: false
  config.vm.provision "shell", path: "setup_kind.sh", privileged: false

  # all files in this directory will be synced to /vagrant

end
```
