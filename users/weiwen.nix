{ config, pkgs, ... }:

{
  nix.trustedUsers = [ "weiwen" ];

  users.extraUsers.weiwen = {
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    isNormalUser = true;
    createHome = true;
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
