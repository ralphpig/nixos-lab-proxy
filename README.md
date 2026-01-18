## My NixOS lab proxy

This opens up a wireguard tunnel to my homelab for publicly exposed services.

#### Structure

- `build/image.nix`
  - `nixos-build build/image.nix` will build a a base NixOS image for DigitalOcean
  - Not sure if I want to build the image with a base config or not

- `configuration.nix`
  - Wraps DigitalOcean init

- `system.nix`
  - Entry point for the system
  
#### Config

- Needs a `local.nix` based off `local.example.nix`
- Secrets are stored in per-secret files in `/etc/nixos/secrets/`
  - `secrets/wireguard-private-key`
