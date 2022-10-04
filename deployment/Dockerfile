FROM node:lts-slim

RUN apt update && apt install -y curl
RUN curl -LO https://github.com/oras-project/oras/releases/download/v0.14.1/oras_0.14.1_linux_amd64.tar.gz
RUN mkdir -p oras-install/
RUN tar -zxf oras_0.14.1_*.tar.gz -C oras-install/
RUN mv oras-install/oras /usr/local/bin/
RUN rm -rf oras_0.14.1_*.tar.gz oras-install/

COPY ./scripts/load_application.sh .
RUN mkdir -p /app

WORKDIR /app

ENV IMAGE=null
ENV REGISTRY_USERNAME=jamesbond
ENV REGISTRY_PASSWORD=007

ENTRYPOINT ["/bin/bash"] 
