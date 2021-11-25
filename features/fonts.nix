{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    cascadia-code

    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    fira-code
    fira-code-symbols

    font-awesome
    
    (nerdfonts.override {
      fonts = [
        "Iosevka"
        "FiraCode"
        "CascadiaCode"
        "Hack"
      ];
    })
  ];
}
