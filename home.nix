{ pkgs, ... }:

{
  targets.genericLinux.enable = true;

  home.username = "weiwen";
  home.homeDirectory = "/home/weiwen";
  
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    bash
    file
    gcc
    gnumake
    htop
    p7zip
    unrar
    unzip

    psmisc
    usbutils

    bat
    imagemagick
    jq
    jsonnet
    ripgrep
    tig
    tldr

    siege

    ranger
    imagemagick
    ffmpeg
    w3m

    # mpv
    # feh

    python3

    fishPlugins.done
  ];

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "Goh Wei Wen";
      userEmail = "goweiwen@gmail.com";
      aliases = {
        co = "checkout";
        ci = "commit";
        cia = "commit --amend";
        s = "status";
         b = "branch";
        p = "pull --rebase";
        pu = "push";
      };
      ignores = [ "*~" "*.swp" ];
      extraConfig = {
        init.defaultBranch = "master";
        pull.rebase = "false";
      };
    };

    tmux = {
      enable = true;
      aggressiveResize = true;
      newSession = true;

      # Force tmux to use /tmp for sockets (WSL2 compat)
      secureSocket = false;

      extraConfig = ''
        # Mouse works as expected
        set-option -g mouse on
        bind c new-window -c "#{pane_current_path}"
      '';
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-airline
        ayu-vim
      ];
      extraConfig = ''
        colorscheme ayu
      '';
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "bass";
          src = pkgs.fetchFromGitHub {
            owner = "edc";
            repo = "bass";
            rev = "2fd3d2157d5271ca3575b13daec975ca4c10577a";
            sha256 = "sha256-fl4/Pgtkojk5AE52wpGDnuLajQxHoVqyphE90IIPYFU=";
          };
        }
      ];
      interactiveShellInit = ''
        set -U fish_greeting
      '';
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
      };
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    ssh.enable = true;
  };
}
