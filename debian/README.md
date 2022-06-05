# Scripts

- all `.sh` files were designed to copy and run with normal users on a server.

# VM Usage

## Expose kind cluster api-server to host

- copy `~/.kube/config` file from the VM to the host machine

- change server url to `https://localhost:8081` (port mapping)

  - **both on vm and host**, generated `0.0.0.0` is not reachable.
  
  - TODO: change local kubeconfig file to localhost

## How to use proxies

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

## Default port mapping

- run `vagrant port` to view the full list

```
# equal to vagrant ssh
ssh vagrant@localhost -p 2222 -i .vagrant/machines/default/virtualbox/private_key
```