#!/usr/bin/bash

args=""

for var in $(compgen -v DWLED_); do
    name=${var#DWLED_}
    value=${!var}
    args="$args -$name $value"
done

./darts-wled $args