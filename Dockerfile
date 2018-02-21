FROM ubuntu:16.04 AS xylo_build
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
WORKDIR /opt/xylo
RUN rm -rf /opt/xylo/src

FROM ubuntu:16.04
RUN apt-get update && apt-get install -y apt-utils
RUN apt-get upgrade -y
RUN apt-get install -y libssl1.0.0 libdb5.3++ libboost-system1.58.0 libboost-filesystem1.58.0 libboost-program-options1.58.0 libboost-thread1.58.0 libqrencode3 libgmp10
COPY --from=xylo_build /opt/xylo /opt/xylo
EXPOSE 7875
VOLUME ["/opt/xylo/data", "/opt/xylo/conf"]
ENTRYPOINT ["/opt/xylo/bin/XYLOd", "-datadir=/opt/xylo/data", "-conf=/opt/xylo/conf/XYLO.conf", "-printtoconsole"]
CMD ["-server"]
