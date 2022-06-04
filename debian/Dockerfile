FROM debian:bullseye

WORKDIR /init-scripts
RUN apt update && apt install sudo
COPY setup_dev.sh setup_k8s_tools.sh setup_coder.sh  .
RUN  sh ./setup_dev.sh \
  && sh ./setup_coder.sh \
  && sh ./setup_k8s_tools.sh