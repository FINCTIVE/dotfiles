FROM debian:bullseye

WORKDIR /init-scripts
RUN apt-get update && apt-get install -y sudo bash
COPY setup_dev.sh setup_k8s_tools.sh setup_coder.sh  .
RUN  bash ./setup_dev.sh \
  && bash ./setup_coder.sh \
  && bash ./setup_k8s_tools.sh