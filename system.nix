{
  pkgs,
  ...
}:

let
  cfg = import ./env.nix;
in
{
  _module.args.cfg = cfg;

  # Ensure that all secret files' permission are set properly
  system.activationScripts.fixSecrets.text = ''
    ${pkgs.systemd}/bin/systemd-tmpfiles --create
  '';

  time.timeZone = "America/New_York";
  networking = {
    hostName = "nixos-lab-proxy";
  };

  services.openssh = {
    enable = true;
    # Default in DigitalOcean image
    # settings.permitRootLogin = "prohibit-password";
  };

  users.users.root = {
    openssh.authorizedKeys.keys = cfg.root_user.ssh_public_keys;
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    randomizedDelaySec = "30min";
    dates = "03:00";
    rebootWindow = {
      lower = "03:00";
      upper = "05:00";
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
    configure = {
      customRC = ''
        set shiftwidth=2 smarttab
        set expandtab
        set tabstop=8 softtabstop=0
      '';
    };
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    wget
    ripgrep
  ];
}
