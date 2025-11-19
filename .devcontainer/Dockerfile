FROM mcr.microsoft.com/devcontainers/base:ubuntu

COPY install-tools.sh /usr/local/bin/install-tools.sh

RUN chmod +x /usr/local/bin/install-tools.sh && /usr/local/bin/install-tools.sh --tools=all

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    jq \
    software-properties-common \
    gnupg \
    lsb-release \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*