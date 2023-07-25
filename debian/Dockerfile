FROM debian:latest

WORKDIR /setup-scripts
COPY ./scripts/*.sh  .
RUN apt-get update && sh basic.sh && sh k8s_tools.sh

WORKDIR /
EXPOSE 8080
CMD ["sh", "-c", "while true; do nc -l 8080; done"]