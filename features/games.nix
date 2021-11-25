{ pkgs, ... }:

{
  programs.steam.enable = true;

  programs.java.enable = true; 
  environment.systemPackages = with pkgs; [
    (steam.override { withJava = true; })
  ];
}
