{
  ...
}:

{
  systemd.tmpfiles.rules = [
    "d /etc/nixos/secrets 0700 root root -"
  ];

  imports = [
    ./services/wireguard.nix
    ./services/traefik.nix
  ];
}
