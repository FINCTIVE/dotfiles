FROM debian:bullseye

WORKDIR /setup
COPY ./scripts/*.sh  ./
RUN apt-get update && apt-get install -y sudo
  && sh basic.sh \
  && sh code_server.sh \
  && sh k8s_tools.sh
CMD ["code-server"]