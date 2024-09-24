#!/bin/bash

# Working directory clean
# Set the clean environment variable
export PORIS_CLEAN=1

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "Script directory: $SCRIPT_DIR"

# Execute the doPorisRuby.sh
$SCRIPT_DIR/doPorisRuby.sh $1 || { echo 'doPorisRuby.sh failed' ; exit 1; }
