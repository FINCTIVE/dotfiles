FROM debian:bullseye

WORKDIR /init-scripts
RUN apt-get update && apt-get install -y sudo
COPY *.sh  ./
RUN  sh ./setup_dev.sh \
  && sh ./setup_coder.sh \
  && sh ./setup_k8s_tools.sh