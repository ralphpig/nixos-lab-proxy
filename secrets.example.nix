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
}
