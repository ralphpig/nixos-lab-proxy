{
  secrets ? { },
  ...
}:

{
  systemd.tmpfiles.rules = [
    "z /etc/nixos/secrets/wireguard-private-key 0600 root root -"
  ];

  systemd.services.wireguard-wg0.serviceConfig = {
    LoadCredential = [
      "wireguard-private-key:/etc/nixos/secrets/wireguard-private-key"
    ];
  };

  networking = {
    firewall = {
      allowedUDPPorts = [ 51820 ];
    };

    wireguard.interfaces = {
      wg0 = {
        ips = secrets.wireguard.ips;
        listenPort = 51820;

        privateKeyFile  = "/run/credentials/wireguard-wg0.service/wireguard-private-key";

        peers = [
          {
            publicKey = secrets.wireguard.public_key;

            allowedIPs = secrets.wireguard.allowed_ips;

            # TODO?: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577
            endpoint = "${secrets.wireguard.endpoint}:51820";

            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
