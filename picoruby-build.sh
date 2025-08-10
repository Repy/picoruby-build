#!/bin/bash

wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main"
sudo apt install cmake-data


git clone https://github.com/raspberrypi/pico-sdk.git -b 2.1.1
git clone https://github.com/raspberrypi/pico-extras.git -b sdk-2.1.1
(cd pico-sdk; git submodule update --init)
export PICO_SDK_PATH=$(pwd)/pico-sdk
export PICO_EXTRAS_PATH=$(pwd)/pico-extras

wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
tar xf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz 

export PATH=$(pwd)/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin:$PATH

git clone https://github.com/picoruby/R2P2.git -b 0.4.1
(cd R2P2; git submodule update --init)
(cd R2P2/lib/picoruby; git submodule update --init)

(cd R2P2; rake setup; rake pico_w)

(cd R2P2; rake clean)


