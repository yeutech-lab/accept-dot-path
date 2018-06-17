#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. $DIR/keys

env
echo $GL_TOKEN
# if reserved, public release will break if package.json contains any of thoose
NPM_RESERVED_SCOPES=@yeutech,@kopaxgroup
# if allowed,
NPM_ALLOWED_SCOPES=@yeutech-labs,@yeutech-oss
NPM_SCOPE=${NPM_SCOPE:-@yeutech-labs}
# current status
#state=$(npx rollup-umd-scripts publish status)
#for i in $(echo $NPM_RESERVED_SCOPES | sed "s/,/ /g")
#do
#  # call your procedure/other scripts here below
#echo "$i"
#done
#if [[ $state = transitive ]]; then
#echo $state
#node testing/gitlab-to-github
#
#if [[ $(curl -s -I https://www.npmjs.com/package/debug | grep HTTP | awk -F ' ' '{print $2}') = 200 ]]; then
#echo
#fi
#fi

echo "Done verifying"

exit 1
