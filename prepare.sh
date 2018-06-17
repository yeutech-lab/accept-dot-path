#!/usr/bin/env bash

state=$(npx rollup-umd-scripts publish status)
echo $state
echo "Done preparing"
