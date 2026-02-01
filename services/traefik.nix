{
  cfg,
  ...
}:

{
  networking.firewall.allowedUDPPorts = [
    34197
    25565
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
        minecraft_tcp.address = ":25565/tcp";
      };
    };

    dynamicConfigOptions = {
      # Factorio
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

      # Minecraft
      tcp.routers.minecraft = {
        service = "minecraft";
        entryPoints = [ "minecraft_tcp" ];
      };
      tcp.services.minecraft = {
        loadBalancer = {
          servers = [
            { address = "${cfg.lab1.ip}:25565"; }
          ];
        };
      };
    };
  };
}
