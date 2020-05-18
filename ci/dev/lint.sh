#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."

  eslint --max-warnings=0 --fix $(git ls-files "*.ts" "*.tsx" "*.js")
  stylelint $(git ls-files "*.css")
  tsc --noEmit
  # See comment in ./ci/container/Dockerfile
  if [[ ! ${CI-} ]]; then
    shellcheck -e SC2046,SC2164,SC2154 $(git ls-files "*.sh")
  fi
}

main "$@"
