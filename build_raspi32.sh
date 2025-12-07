#!/bin/sh
#
# Example of how to build the SDL2 version of Mini vMac on Linux
# This targets my Raspberry Pi Zero W 2 running on a 640x480 display.

# we need to build the setup tool first
if [ ! -x ./setup_t ]; then
	gcc -o setup_t setup/tool.c
fi

# run setup tool to generate makefile generator
./setup_t -maintainer "egon.rath@gmail.com" \
        -homepage "https://github.com/egrath" \
        -n "minivmac-3.7-linuxarm32" \
        -e bgc \
        -t larm \
        -cpu arm \
        -m II \
        -hres 640 -vres 480 -depth 3 \
        -sound 1 \
        -sony-sum 1 -sony-tag 1 \
        -speed 4 -ta 2 -mem 4M \
        -chr 0 -drc 1 -sss 3 \
        -fullscreen 1 \
        -var-fullscreen 1 \
        -api sd2 \
        > setup.sh

# generate makefile and build
bash -x ./setup.sh
make clean
make -j $(nproc)

