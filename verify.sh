#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -e
. $DIR/keys.sh

state=$(npx rollup-umd-scripts publish status)

if [[ $state = transitive ]]; then
  # current status
  # Package name before release in GitHub
  scope=$(cat package.json | jq -r .transitive.scope)
  license=$(cat package.json | jq -r .transitive.license)
  licenseForbidden=UNLICENSED

  ## Reserved can't go public. Release will break if dependencies in package.json contains any of those
  #NPM_RESERVED_SCOPES=@yeutech,@kopaxgroup
  #
  ## Allowed are authorized public scope, if a scope is used, it must include one of those
  #NPM_ALLOWED_SCOPES=@yeutech-labs,@yeutech-oss

  if [ "${license,,}" = "${licenseForbidden,,}" ]; then
    echo "[Error] GitHub release abort. Reason: your license ${license} does not have a valid license."
    exit 1
  fi

  for i in $(echo ${NPM_RESERVED_SCOPES} | sed "s/,/ /g")
  do
    if [[ $(cat package.json | jq .dependencies | grep "$i/") ]]; then
      echo "[Error] GitHub release abort. Reason: this module contains protected dependencies within scope $i."
      exit 1
    fi
  #  if [[ $(cat package.json | jq .devDependencies | grep "$i/") ]]; then
  #    echo "[Error] GitHub release abort. Reason: this module contains protected devDependencies within scope $i."
  #    exit 1
  #  fi
    if [[ $(cat package.json | jq .peerDependencies | grep "$i/") ]]; then
      echo "[Error] GitHub release abort. Reason: this module contains protected peerDependencies within scope $i."
      exit 1
    fi
    if [[ $(cat package.json | jq .optionalDependencies | grep "$i/") ]]; then
      echo "[Error] GitHub release abort. Reason: this module contains protected optionalDependencies within scope $i."
      exit 1
    fi
  done

  forbidden=true
  for i in $(echo ${NPM_ALLOWED_SCOPES} | sed "s/,/ /g")
  do
    if [[ ${i} = "@$scope" ]]; then
      forbidden=false
    fi
  done

  if [[ ${forbidden} = true ]]; then
    echo "[Error] GitHub release abort. Reason: the scope $scope is not an authorized scope."
    exit 1
  fi

fi
echo "Done verifying"
exit 1
