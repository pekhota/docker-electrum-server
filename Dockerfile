FROM phusion/baseimage:0.11

ENV ELECTRUM_VERSION 3.1.3

# install environment dependencies
RUN apt-get update && apt-get install -y \
  python3-setuptools \
  python3-pyqt5 \
  python3-pip \
  expect \
  curl \
  jq

# install electrum
RUN pip3 install https://download.electrum.org/${ELECTRUM_VERSION}/Electrum-${ELECTRUM_VERSION}.tar.gz
RUN pip3 install requests==2.19.1

# copy the entrypoint script and the scripts to work with electrum into a container
COPY ./entrypoint.sh /entrypoint.sh
COPY ./el-scripts /el-scripts

# give the scripts execution rights
RUN chmod +x /entrypoint.sh
RUN chmod -R +x /el-scripts/


ENTRYPOINT /entrypoint.sh
