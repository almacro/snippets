#!/usr/bin/env bash
# This script assumes diceware file lives in $HOME/.diceware
# A good candidate for diceware contents is
#     http://world.std.com/~reinhold/diceware.wordlist.asc
#
DICEWARE=$HOME/.diceware

TIMES=${1:-5}  # how many times to roll the dice
ROLLS=$(cat /dev/urandom | env LANG=C tr -dc '1-6' | fold -w 5 | head -n $TIMES)

DICEPHRASE=$(for d in $ROLLS; do grep $d $DICEWARE | awk '{print $2}'; done)
echo $DICEPHRASE
