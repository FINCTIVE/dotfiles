FROM debian:bullseye

WORKDIR /init-scripts
RUN apt-get update && apt-get install -y sudo
COPY *.sh  ./
RUN  sh ./setup_dev.sh \
  && sh ./setup_code_server.sh \
  && sh ./setup_k8s_tools.sh
CMD ["code-server"]