{
  ...
}:

{
  systemd.tmpfiles.rules = [
    "d /etc/credentials 0700 root root -"
  ];

  imports = [
    ./services/wireguard.nix
    ./services/traefik.nix
  ];
}
