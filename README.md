
XYLO development tree

XYLO is a PoW/PoS hybrid cryptocurrency.

XYLO is dependent upon libsecp256k1 by sipa, the sources for which can be found here:
https://github.com/bitcoin/secp256k1


Block Spacing: 2 minutes

Diff Retarget: Each Block

Maturity: 20 Blocks

Stake Minimum Age: 5 Hours

40 MegaByte Maximum Block Size (40X Bitcoin Core)

P2P Port: 7875

RPC Port: 7876

XYLO includes an Address Index feature, based on the address index API (searchrawtransactions RPC command) implemented in Bitcoin Core but modified implementation to work with the XYLO codebase (PoS coins maintain a txindex by default for instance).

Initialize the Address Index By Running with -reindexaddr Command Line Argument.  It may take 10-15 minutes to build the initial index.

Docker
======

This repository contains a Dockerfile to build a slim image containing only the XYLOd binary and its dependencies.
The slim image is created through a multistage process by first creating a full build image, compiling the binary
in this image and then creating the slim image by copying the binary form the build image.

A precompiled image can be pulled from [Docker Hub](https://hub.docker.com/r/robkaandorp/xylo/).

To build the image yourself run the following docker command:
`docker build -t xylo https://github.com/robkaandorp/xylo.git`
