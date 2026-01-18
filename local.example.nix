{
  wireguard = {
    ips = [ "10.0.0.2/24" ]; # wg interface ip
    allowed_ips = [ "10.0.0.0/24" ];
    public_key = "server public key";
    endpoint = "server endpoint";
  };

  lab1 = {
    ip = "10.0.0.100"; # ip of lab1 server to route to
  };

  root_user = {
    # DigitalOcean image already pre-loads SSH assigned during Droplet creation
    ssh_public_keys = [
      "ssh-ed25519 ..."
    ]
  };
}
