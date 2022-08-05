#!/bin/bash -e
set -o pipefail

# fetch upstream
if [ -d repo ]; then
    cd repo
    git fetch origin
    git reset --hard origin/master
else
    ssh-keyscan github.com >> ~/.ssh/known_hosts
    git clone "$REPO_URL" repo
    cd repo
fi

# get list of hashes
curl -f https://cdn.discordapp.com/bad-domains/hashes.json | jq -r 'sort | .[]' > hashes.txt
curl -f https://cdn.discordapp.com/bad-domains/updated_hashes.json | jq -r 'sort | .[]' > updated_hashes.txt

# commit + push
if [ -n "$(git status --porcelain)" ]; then
    git config --local user.email "bot@localhost"
    git config --local user.name "update-bot"

    git add -A
    git commit -m "Update:$(git diff --shortstat --cached | cut -d, -f2-)"
    git push origin master
fi
