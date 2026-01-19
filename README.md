## My NixOS lab proxy

This opens up a wireguard tunnel to my homelab for publicly exposed services.

#### Structure

- `build/digital-ocean-image.nix`
  - `nixos-build build/digital-ocean-image.nix` will build a a base NixOS image for DigitalOcean
  - Not sure if I want to build the image with a base config or not

- `configuration.nix`
  - Wraps DigitalOcean init

- `system.nix`
  - Entry point for the system
  
#### Config

- Needs a `env.nix` based off `env.example.nix`
- Secrets are stored in per-secret files in `/etc/credentials/`, copied from `./secrets/`
  - `secrets/wireguard-private-key`
