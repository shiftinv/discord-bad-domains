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

function fetch_items() {
    items="$(curl -f "$1" | jq -r 'sort | .[]')"
    if [ -z "$items" ]; then
        echo "Got empty list, something probably went wrong." >&2
        exit 1
    fi
    echo "$items"
}

# get list of hashes
fetch_items https://cdn.discordapp.com/bad-domains/hashes.json > hashes.txt
fetch_items https://cdn.discordapp.com/bad-domains/updated_hashes.json > updated_hashes.txt

# commit + push
if [ -n "$(git status --porcelain)" ]; then
    git config --local user.email "bot@localhost"
    git config --local user.name "update-bot"

    git add -A
    git commit -m "Update:$(git diff --shortstat --cached | cut -d, -f2-)"
    git push origin master
fi
