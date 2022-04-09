# **ExaWinePi**
![Docker Pulls](https://img.shields.io/docker/pulls/flameshikari/exawinepi?style=flat) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/flameshikari/exawinepi/latest)

Dockerized [ExaGear](http://elbrus-technologies.com) with preinstalled Wine for running 32-bit Windows apps on [RPi](https://www.raspberrypi.org) [3](https://www.raspberrypi.com/products/raspberry-pi-3-model-b-plus)/[4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b) or anything that is armhf/arm64.

## Usage
```bash
# build from repo
docker build -t exawinepi .

# run inside of guest os
docker run -it flameshikari/exawinepi

# run outside of guest os
docker run -it --entrypoint /bin/bash flameshikari/exawinepi
```

## Tips
- guest OS root path inside of the container is `/opt/exagear/images/default/`
- Dockerfile commands `CMD` and `RUN` are executed outside the guest OS, you should use `exagear default -- <command>`


## Credits
- image is based on [this guide](https://insrt.uk/post/exagear-install)
- official [user guide](https://vdocuments.mx/embed/v1/eltechs-exagear-desktop-guide-12.html)
