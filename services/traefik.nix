{
  cfg,
  ...
}:

{
  networking.firewall.allowedUDPPorts = [
    34197
  ];

  services.traefik = {
    enable = true;
    staticConfigOptions = {
      log.level = "INFO";
      accessLog = { };

      api = {
        dashboard = false;
        insecure = false;
      };
      entryPoints = {
        factorio_udp.address = ":34197/udp";
      };
    };

    dynamicConfigOptions = {
      udp.routers.factorio = {
        service = "factorio";
        entryPoints = [ "factorio_udp" ];
      };
      udp.services.factorio = {
        loadBalancer = {
          servers = [
            { address = "${cfg.lab1.ip}:34197"; }
          ];
        };
      };
    };
  };
}
