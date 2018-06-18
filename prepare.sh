#!/usr/bin/env bash

state=$(npx rollup-umd-scripts publish status)

if [[ $state = transitive ]]; then
  # Readme text
  name=$(cat package.json | jq -r .transitive.name)
  scopedName=$(cat package.json | jq -r .transitive.scopeName)
  previousRepositoryUrl=$(cat package.json | jq -r .repository.url)
  gitlabUrl=${previousRepositoryUrl%.*}
  repositoryUrl=$(cat package.json | jq -r .transitive.repository.url)
  githubUrl=${repositoryUrl%.*}

  rename=""
  if [[ scopedName != name ]]; then
    rename=" has been renamed [${scopedName}](https://www.npmjs.com/package/${scopedName}) and"
  else
    rename=" has been"
  fi
  text="This [project](${gitlabUrl})${rename} moved to ${githubUrl}."

  echo ""

  # prepare github package.json
  jq '. * .transitive | del(.transitive)' package.json > package.github.json
  mv README.md README.github.md
  echo "${text}" > README.md

  git add README.md package.github.json
  git commit -m "chore(publish): [skip ci] ${text}"
  git push origin HEAD:master
  git tag github-snapshot
  git push --tags

  # prepare github release
  mv README.github.md README.md

  # prepare github package.json
  mv package.github.json package.json
  git add README.md package.json
  git commit -m "chore(publish): [skip ci] ${text}"
fi

echo "Done preparing"
