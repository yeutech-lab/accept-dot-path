#!/usr/bin/env bash


echo $GL_TOKEN
echo $GH_TOKEN
state=$(npx rollup-umd-scripts publish status)
echo $state

node testing/gitlab-to-github

exit 1
