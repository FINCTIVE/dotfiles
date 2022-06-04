FROM debian:bullseye

WORKDIR /init-scripts
RUN apt update && apt install sudo
COPY setup_coder.sh setup_dev.sh setup_k8s_tools.sh .
RUN sh ./setup_coder.sh \
  && sh ./setup_dev.sh \
  && sh ./setup_k8s_tools.sh