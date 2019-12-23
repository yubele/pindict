# define ubuntu version, you can use --build-arg
ARG ubuntu_version="18.10"
FROM ubuntu:${ubuntu_version}

# Dockerfile on bash
SHELL ["/bin/bash", "-c"]

# default node version, you can use --build-arg
ARG node_version="v13.5.0"

# default nvm version, you can use --build-arg
ARG nvm_version="v0.35.2"

RUN apt update
RUN apt install -y --no-install-recommends curl git ca-certificates

# installv nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${nvm_version}/install.sh | bash
ENV NVM_DIR "/root/.nvm"
RUN . ${NVM_DIR}/nvm.sh \
    && nvm install ${node_version} \
    && nvm alias default ${node_version}
    
# remove the files
RUN apt-get remove -y curl ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8080