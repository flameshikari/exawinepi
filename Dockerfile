FROM ubuntu:18.04

SHELL ["/bin/bash", "-c"]

WORKDIR /tmp/

RUN \
apt-get update && \
apt-get install -y bash binfmt-support coreutils cron curl findutils iproute2 iputils-ping && \
apt-get clean

RUN \
[[ $(uname -m) == armhf ]] && arch=armhf || arch=arm64 && \
curl -so exagear-translator.deb https://dl.insrt.uk/mirror/exagear/exagear_3428-1_$arch.deb && \
curl -so exagear-guest-ubuntu.deb https://dl.insrt.uk/mirror/exagear/exagear-guest-ubuntu-1804_3428_all.deb && \
dpkg -i exagear-translator.deb exagear-guest-ubuntu.deb

RUN \
rmdir /opt/exagear/lic && rm /opt/exagear/bin/actool /opt/exagear/images/default/etc/resolv.conf && \
printf '\x00\xf0\x20\xe3\x01\x00\xa0\xe3' | dd of='/opt/exagear/bin/ubt_x32a32_al_mem2g' bs=1 seek=866740 count=8 conv=notrunc 2> /dev/null && \
printf '\x00\xf0\x20\xe3\x01\x00\xa0\xe3' | dd of='/opt/exagear/bin/ubt_x32a32_al_mem3g' bs=1 seek=996256 count=8 conv=notrunc 2> /dev/null

RUN exagear default -- <<< "\
export DEBIAN_FRONTEND='noninteractive' && \
apt-get update && \
rm /var/lib/dpkg/statoverride /var/lib/dpkg/lock && \
apt-get -q install -y wine-stable && \
apt-get clean"

RUN rm -rf ./*

CMD exagear default