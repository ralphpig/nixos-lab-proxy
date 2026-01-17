{
  secrets ? { },
  ...
}:

{
  networking.firewall.allowedUDPPorts = [
    34197
  ];

  # systemd.services.traefik.environment = {
  #   CLOUDFLARE_ZONE_API_TOKEN = secrets.cloudflare.zoneApiToken;
  #   CLOUDFLARE_DNS_API_TOKEN = secrets.cloudflare.dnsApiToken;
  # };

  # If I need docker
  # systemd.services.traefik.serviceConfig.SupplementaryGroups = [ "podman" ];

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

      # certificatesResolvers = {
      #   cloudflare.acme = {
      #     email = secrets.cloudflare.email;
      #     dnsChallenge = {
      #       provider = "cloudflare";
      #       propagation.delayBeforeChecks = 900; # 15 min to ensure propagation
      #       resolvers = [
      #         "1.1.1.1:53"
      #         "1.0.0.1:53"
      #       ];
      #     };
      #   };
      # };

      # If I need docker
      # providers = {
      #   docker = {
      #     endpoint = "unix:///run/podman/podman.sock";
      #   };
      # };
    };

    dynamicConfigOptions = {
      udp.routers.factorio = {
        service = "factorio";
        entryPoints = [ "factorio_udp" ];
      };
      udp.services.factorio = {
        loadBalancer = {
          servers = [
            { address = "${secrets.lab1.ip}:34197"; }
          ];
        };
      };

      # http = {
      #   middlewares.https_redirect = {
      #     redirectScheme = {
      #       scheme = "https";
      #       permanent = true;
      #     };
      #   };
      #   serversTransports.skip_tls_transport = {
      #     insecureSkipVerify = true;
      #   };
      # };

      # Traefik
      # http.routers.traefik = {
      #   rule = "Host(`${secrets.traefik.route}`)";
      #   entryPoints = [ "websecure" ];
      #   service = "api@internal";
      #   middlewares = [ "https_redirect" ];
      #   tls = {
      #     certResolver = "cloudflare";
      #   };
      # };

      # Home Assistant
      # http.routers.home_assistant = {
      #   rule = "Host(`${secrets.home_assistant.route}`)";
      #   entryPoints = [ "websecure" ];
      #   service = "home_assistant";
      #   middlewares = [ "https_redirect" ];
      #   tls = {
      #     certResolver = "cloudflare";
      #   };
      # };
      # http.services.home_assistant = {
      #   loadBalancer = {
      #     servers = [
      #       { url = "http://127.0.0.1:8123"; }
      #     ];
      #   };
      # };

    };
  };

}
