FROM debian:latest

WORKDIR /workspace
COPY ./scripts/*.sh  ./scripts
RUN apt-get update && apt-get install -y sudo \
  && sh basic.sh \
  && sh k8s_tools.sh

EXPOSE 8080
CMD ["sh", "-c", "while true; do nc -l 8080; done"]