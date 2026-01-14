{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./modules/hardware/additional-config.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  time.timeZone = "Europe/Moscow";

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      wget
      waybar
      kitty
      git
      # zapret
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };

  services = {
    getty.autologinUser = "never";

    ollama = {
      enable = true;
      package = pkgs.ollama-cpu;
      loadModels = [
        "qwen2.5:3b"
      ];
    };

    #   zapret = {
    #     enable = true;
    #     params = [
    #       "--dpi-desync=fake,disorder2"
    #       "--dpi-desync-ttl=1"
    #       "--dpi-desync-autottl=2"
    #     ];
    #     whitelist = [
    #       "youtube.com"
    #       "googlevideo.com"
    #       "ytimg.com"
    #       "youtu.be"
    #       "discord-attachmets-uploads-prd.storage.googleapis.com"
    #       "googleapis.com"
    #     ];
    #   };
  };

  networking = {
    hostName = "nevernix";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  programs = {
    # firefox.enable = true;

    gamemode.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    dms-shell = {
      enable = true;
      systemd = {
        enable = false;
      };
    };

    zsh = {
      enable = true;
    };

    bash = {
      enable = true;
    };
  };

  users.users.never = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  fonts.packages = with pkgs; [
    roboto
    nerd-fonts.jetbrains-mono
  ];

  system.stateVersion = "25.11";
}
