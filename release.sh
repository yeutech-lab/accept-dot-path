#!/usr/bin/env bash


echo $1 > ~/release_version

state=$(npx rollup-umd-scripts publish status)
echo $state
echo "Done release"
