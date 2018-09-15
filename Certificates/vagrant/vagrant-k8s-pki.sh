#!/usr/bin/env bash

rm -rf out
mkdir -p out
cd out
ssh-keygen -t rsa -N "" -f ./rke.key