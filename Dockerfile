FROM ubuntu:18.04

WORKDIR /tmp/

RUN apt-get update && apt-get install -y \
    bash iputils-ping coreutils findutils curl binfmt-support nano tcpdump openssl \
    cron wget iproute2 libatm1 libelf1 libmnl0 libxtables12 libasound2 && \
    apt-get clean

RUN [[ $(uname -m) == armhf ]] && arch=armhf || arch=arm64 && \
    wget -O exagear-translator.deb https://dl.insrt.uk/mirror/exagear/exagear_3428-1_$arch.deb && \
    wget -O exagear-dsound-server.deb https://dl.insrt.uk/mirror/exagear/exagear-dsound-server_010_$arch.deb && \
    wget -O exagear-guest-ubuntu.deb https://dl.insrt.uk/mirror/exagear/exagear-guest-ubuntu-1804_3428_all.deb

RUN dpkg -i exagear-translator.deb exagear-dsound-server.deb exagear-guest-ubuntu.deb

RUN rmdir /opt/exagear/lic && rm /opt/exagear/bin/actool /opt/exagear/images/default/etc/resolv.conf && \
    printf '\x00\xf0\x20\xe3\x01\x00\xa0\xe3' | dd of='/opt/exagear/bin/ubt_x32a32_al_mem2g' bs=1 seek=866740 count=8 conv=notrunc 2> /dev/null && \
    printf '\x00\xf0\x20\xe3\x01\x00\xa0\xe3' | dd of='/opt/exagear/bin/ubt_x32a32_al_mem3g' bs=1 seek=996256 count=8 conv=notrunc 2> /dev/null

COPY ./install.sh ./

RUN exagear default -- /bin/bash /tmp/install.sh

RUN rm -rf ./*

CMD exagear default
