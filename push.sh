#!/usr/bin/env bash
# Re-push this screenshot repo to GitHub.
#
# The token is NEVER stored in this file or in .git/config.
# Pass it in at run time:
#
#   GH_TOKEN=ghp_xxxxxxxx ./push.sh
#
# Tip: revoke the token at https://github.com/settings/tokens when you're done with it.
set -euo pipefail

OWNER="spencerbby8-gif"
NAME="bandlab-screenshots"
DIR="$(cd "$(dirname "$0")" && pwd)"

: "${GH_TOKEN:?Set GH_TOKEN first, e.g.  GH_TOKEN=ghp_xxx ./push.sh}"

cd "$DIR"
git init -q -b main 2>/dev/null || true
git config user.name  "$OWNER"
git config user.email "301615105+$OWNER@users.noreply.github.com"
git add -A
git commit -q -m "${1:-Update screenshots}" || echo "nothing new to commit"
git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/$OWNER/$NAME.git"
git push -q "https://x-access-token:${GH_TOKEN}@github.com/$OWNER/$NAME.git" main:main
echo "pushed -> https://github.com/$OWNER/$NAME"
