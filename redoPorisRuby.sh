#!/bin/bash

# Working directory clean
# Set the clean environment variable
export PORIS_CLEAN=1

# Execute the doPorisRuby.sh
./doPorisRuby.sh $1 || { echo 'doPorisRuby.sh failed' ; exit 1; }
