FROM phusion/baseimage:0.11

RUN apt-get update && apt-get install -y \
  python3-setuptools \
  python3-pyqt5 \
  python3-pip \
  expect \
  curl \
  jq


RUN pip3 install https://download.electrum.org/3.1.3/Electrum-3.1.3.tar.gz

VOLUME /app/electrum/
VOLUME /el-scripts/

COPY ./entrypoint.sh /entrypoint.sh
COPY ./el-scripts /el-scripts

RUN chmod +x /entrypoint.sh
RUN chmod -R +x /el-scripts/

ENTRYPOINT /entrypoint.sh
