FROM debian:bullseye

WORKDIR /init-scripts
COPY setup_coder.sh setup_dev.sh setup_k8s_tools.sh .
RUN sh ./setup_coder.sh \
  && sh ./setup_dev.sh \
  && sh ./setup_k8s_tools.sh