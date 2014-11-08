#!/bin/bash -eux

rm -f *.box

packer build debian2docker.json