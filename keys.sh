#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -e

if [[ -v "CI_SECRET" && -f ~/helpers.sh ]]; then
  . ~/helpers.sh
  source <(getSecuredEnv)

  # commit message
  git config --global user.email "dev@kopaxgroup.com"
  git config --global user.name "Gitlab-CI"
  git config --global push.default matching

  # connect to npm
  if [[ -v "NPM_TOKEN_KOPAXGROUP" ]]; then
    echo "//npm.kopaxgroup.com/:_authToken=${NPM_TOKEN_KOPAXGROUP}" >> ~/.npmrc
    echo npm set registry https://npm.kopaxgroup.com
    npm set registry https://npm.kopaxgroup.com
  fi

  # with access
  if [[ -v "GL_TOKEN" || -v "GITLAB_TOKEN" ]]; then

    # this can allow push to repo
    echo "umd detected"
    if [[ "${CI_PROJECT_URL}" =~ (([^/]*/){3}) ]]; then
      mkdir -p $HOME/.config/git
      echo "${BASH_REMATCH[1]/:\/\//://gitlab-ci-token:${GL_TOKEN:-$GITLAB_TOKEN}@}" > $HOME/.config/git/credentials
      git config --global credential.helper store
    fi

    # this will do check when on master
    if [[ "${CI_COMMIT_REF_NAME}" = master ]]; then

      # this will protect the dev branch if not protected
      devProtectedStatus=$(curl -s -L -H "PRIVATE-TOKEN: ${GL_TOKEN:-$GITLAB_TOKEN}" "https://module.kopaxgroup.com/api/v4/projects/${CI_PROJECT_ID}/protected_branches/dev" | jq .message)
      if [[ $devProtectedStatus = '"404 Not found"' ]]; then
        echo "[Warning] dev branch is not protected!"
        curl -s -L -X POST -H "PRIVATE-TOKEN: ${GL_TOKEN:-$GITLAB_TOKEN}" "https://module.kopaxgroup.com/api/v4/projects/${CI_PROJECT_ID}/protected_branches?name=dev&push_access_level=30&merge_access_level=40"
        echo "[Done] dev branch is now protected."
      fi

    fi
#    if [[ "${CI_COMMIT_REF_NAME}" != $(node -p "require('./package.json').release.branch") && "${CI_JOB_STAGE}" != declination ]]; then
#      . $DIR/unset.sh
#    fi
  fi

fi
