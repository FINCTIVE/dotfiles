dotfiles managed by [chezmoi](https://www.chezmoi.io/install/)

## debian server

### minimal cli setup

```
curl -L https://finctive.github.io/dotfiles | sh
```

### full tool set 

vagrant virtual machine: [debian(amd64)](https://github.com/FINCTIVE/dotfiles/tree/main/debian)

```
curl -L https://raw.githubusercontent.com/FINCTIVE/dotfiles/main/debian/init.sh | sh
```

### docker container

`finctive/playground`, [Dockerfile](https://github.com/FINCTIVE/dotfiles/blob/main/debian/Dockerfile)

- basic cli setup
- code-server
- k8s ops tools

## TODO

- [x] ARM support for [k8s tools setup scripts](https://github.com/FINCTIVE/dotfiles/blob/main/debian/setup_k8s_tools.sh)
- [ ] ARM support for Docker container
