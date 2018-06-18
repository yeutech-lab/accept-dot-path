#!/usr/bin/env bash


echo $1 > ~/release_version

state=$(npx rollup-umd-scripts publish status)

if [[ $state = public ]]; then
  echo $state
fi

echo "Done release"
