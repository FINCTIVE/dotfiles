FROM debian:bullseye

WORKDIR /setup
COPY ./scripts/*.sh  ./
RUN apt-get update && apt-get install -y sudo \
  && sh basic.sh \
  && sh k8s_tools.sh \
  && curl -fsSL https://code-server.dev/install.sh | sh \
  && sed -i.bak 's/auth: password/auth: none/' ~/.config/code-server/config.yaml
EXPOSE 8080
CMD ["code-server"]