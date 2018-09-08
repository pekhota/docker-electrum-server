FROM phusion/baseimage:0.11

RUN apt-get update && apt-get install -y \
  python3-setuptools \
  python3-pyqt5 \
  python3-pip \
  expect \
  curl \
  jq

ENV ELECTRUM_ENV_NETWORK_TYPE ""
ENV ELECTRUM_ENV_VERSION "3.1.3"
ENV ELECTRUM_ENV_WALLET_PASSWORD ""

RUN pip3 install https://download.electrum.org/${ELECTRUM_ENV_VERSION}/Electrum-${ELECTRUM_ENV_VERSION}.tar.gz

VOLUME /app/electrum/

WORKDIR /app

COPY . /app

EXPOSE 7777

RUN chmod +x /app/docker-entrypoint.sh
RUN chmod +x /app/electrum-watcher.sh

ENTRYPOINT ["/app/docker-entrypoint.sh"]

CMD ["/bin/bash", "/app/electrum-watcher.sh"]

