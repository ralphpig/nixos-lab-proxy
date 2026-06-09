#!/usr/bin/env bash
set -e

if [[ -z "${NIXOS_HOST:-}" ]]; then
  echo "NIXOS_HOST environment variable must be set (user@host.domain.com)" >&2
  exit 1
fi

rsync -rv \
  --delete \
  --exclude './secrets/' \
  --rsync-path="sudo rsync" \
  ./ ${NIXOS_HOST}:/etc/nixos/;

rsync -rv \
  --delete \
  --rsync-path="sudo rsync" \
  ./secrets/ ${NIXOS_HOST}:/etc/credentials/;

nixos-rebuild \
  --sudo \
  -I nixos-config=./configuration.nix \
  --target-host "${NIXOS_HOST}" \
  switch "$@";
