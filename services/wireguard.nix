{
  cfg,
  ...
}:

{
  systemd.tmpfiles.rules = [
    "z /etc/credentials/wireguard-private-key 0600 root root -"
  ];

  systemd.services.wireguard-wg0.serviceConfig = {
    LoadCredential = [
      "wireguard-private-key:/etc/credentials/wireguard-private-key"
    ];
  };

  networking = {
    firewall = {
      # Since this is the sole connection initiator, we don't need to have this port open
      # allowedUDPPorts = [ 51820 ];
    };

    wireguard.interfaces = {
      wg0 = {
        ips = cfg.wireguard.ips;
        listenPort = 51820;

        privateKeyFile = "/run/credentials/wireguard-wg0.service/wireguard-private-key";

        peers = [
          {
            endpoint = "${cfg.wireguard.endpoint}:51820";
            allowedIPs = cfg.wireguard.allowed_ips;
            publicKey = cfg.wireguard.public_key;

            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
