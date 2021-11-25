{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bash
    gcc
    gnumake
    ripgrep
    tig

    p7zip

    psmisc
    usbutils

    ranger
    file
    mpv
    imagemagick
    ffmpeg
    w3m
    feh

    python3

    fishPlugins.done
  ];

  programs = {
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

    alacritty = {
      enable = true;
      settings = {
        window.padding.x = 4;
        window.padding.y = 4;
        window.dynamic_padding = true;
      };
    };

    bat.enable = true;
    firefox.enable = true;
    jq.enable = true;
    ssh.enable = true;
    htop.enable = true;
  };
}
