FROM debian:latest

WORKDIR /setup-scripts
COPY ./setup.sh .
RUN apt-get update && apt-get install -y sudo && sh setup.sh

WORKDIR /
EXPOSE 8080
CMD ["sh", "-c", "while true; do nc -l 8080; done"]
