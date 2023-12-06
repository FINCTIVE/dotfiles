FROM debian:latest

WORKDIR /setup-scripts
COPY ./scripts/*.sh  .
RUN apt-get update && apt-get install -y sudo && sh setup_cli.sh && sh setup_cli_k8s.sh

WORKDIR /
EXPOSE 8080
CMD ["sh", "-c", "while true; do nc -l 8080; done"]
