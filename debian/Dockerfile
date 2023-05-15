FROM debian:bullseye

WORKDIR /setup
COPY ./scripts/*.sh  ./
RUN apt-get update && apt-get install -y sudo \
  && sh basic.sh \
  && sh k8s_tools.sh \
  && curl -fsSL https://code-server.dev/install.sh | sh \
  && mkdir -p ~/.config/code-server \
  && cat <<EOF > ~/.config/code-server/config.yaml
bind-addr: 0.0.0.0:8080
cert: false
auth: none
EOF

EXPOSE 8080
CMD ["code-server"]