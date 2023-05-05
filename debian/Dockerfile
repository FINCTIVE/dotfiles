FROM debian:bullseye

WORKDIR /setup
COPY ./scripts/*.sh  ./
RUN apt-get update && apt-get install -y sudo \
  && sh basic.sh \
  && sh k8s_tools.sh \
  && curl -fsSL https://code-server.dev/install.sh | sh
EXPOSE 8080
CMD ["code-server"]