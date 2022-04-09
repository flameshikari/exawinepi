#!/bin/bash

apt-get update
rm /var/lib/dpkg/statoverride /var/lib/dpkg/lock
dpkg --configure -a
apt-get -fy install curl iproute2 iputils-ping nano wine-stable
