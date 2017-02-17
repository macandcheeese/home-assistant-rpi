#!/bin/sh
# From official home-assistant virtualization/ folder.

set -e

cd "$(dirname "$0")/.."

if [ ! -d build ]; then
  mkdir build
fi

cd build

if [ -d python-openzwave ]; then
  cd python-openzwave
  git pull --recurse-submodules=yes
  git submodule update --init --recursive
else
  git clone --branch python3 --recursive --depth 1 https://github.com/OpenZWave/python-openzwave.git
  cd python-openzwave
fi

git checkout python3
pip3 install --upgrade cython
PYTHON_EXEC=`which python3` make build
PYTHON_EXEC=`which python3` make install

mkdir -p /usr/local/share/python-openzwave
cp -R openzwave/config /usr/local/share/python-openzwave/config