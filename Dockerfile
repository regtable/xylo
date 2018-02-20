FROM ubuntu:16.04
RUN apt-get update && apt-get install -y apt-utils
RUN apt-get upgrade -y
RUN apt-get install -y autoconf autogen build-essential libssl-dev libdb++-dev libboost-all-dev libqrencode-dev libgmp-dev
RUN apt-get install -y dos2unix
COPY src /opt/xylo/src/
WORKDIR /opt/xylo/src
RUN dos2unix leveldb/build_detect_platform
RUN dos2unix secp256k1/**
RUN make -f makefile.unix USE_UPNP=
RUN strip XYLOd
RUN mkdir /opt/xylo/bin && cp XYLOd /opt/xylo/bin/
RUN make -f makefile.unix clean
RUN mkdir /opt/xylo/data
RUN mkdir /opt/xylo/conf
RUN /opt/xylo/bin/XYLOd 2>&1 | grep ^rpc > /opt/xylo/conf/XYLO.conf && echo "Config file created"
RUN chmod 400 /opt/xylo/conf/XYLO.conf
WORKDIR /opt/xylo
EXPOSE 7875
VOLUME ["/opt/xylo/data", "/opt/xylo/conf"]
CMD ["/opt/xylo/bin/XYLOd", "-datadir=/opt/xylo/data", "-conf=/opt/xylo/conf/XYLO.conf", "-printtoconsole", "-server"]
