{
  pkgs,
  ...
}:

{
  imports = [
    ./services.nix
  ];

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "03:00";
    rebootWindow = {
      lower = "03:00";
      upper = "05:00";
    };
  };

  time.timeZone = "America/New_York";

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
    configure = {
      customRC  = ''
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

  networking = {
    hostName = "nixos-lab-proxy";
  };
}
