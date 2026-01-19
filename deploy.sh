#!/usr/bin/env bash
set -e

if [[ -z "${NIXOS_HOST:-}" ]]; then
  echo "NIXOS_HOST environment variable must be set (user@host.domain.com)" >&2
  exit 1
fi

# Will place secrets in /etc/credentials if it already exists
# scp -r ./secrets ${NIXOS_HOST}:/etc/credentials;

rsync -rv --delete ./secrets/ ${NIXOS_HOST}:/etc/credentials/;
nixos-rebuild --target-host ${NIXOS_HOST} -I nixos-config=./configuration.nix switch;
