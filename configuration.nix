{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelModules = [ "xt_TPROXY" ];

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  time.timeZone = "Europe/Moscow";

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    bluetooth = {
      enable = true;
    };
  };

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
      v2ray-geoip
      v2ray-domain-list-community
      grim
      papirus-icon-theme
      kdePackages.qt6ct
      zfxtop
      (discord.override {
        withVencord = true;
      })
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };

    sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      GDK_PIXBUF_MODULE_FILE = "$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)";
    };

    pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
  };

  services = {
    getty.autologinUser = "never";

    blueman.enable = true;

    pulseaudio.enable = false;

    upower.enable = true;

    v2raya = {
      enable = true;
      cliPackage = pkgs.xray;
    };

    ollama = {
      enable = true;
      package = pkgs.ollama-cpu;
      loadModels = [
        "qwen2.5:3b"
      ];
    };

    xserver.xkb = {
      layout = "us,ru";
      options = "caps:escape";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  networking = {
    hostName = "nevernix";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  programs = {
    dconf.enable = true;

    zsh = {
      enable = true;
    };

    bash = {
      enable = true;
    };
  };

  users.users.never = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "video"
      "audio"
      "input"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  fonts = {
    packages = with pkgs; [
      roboto
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      noto-fonts-color-emoji
    ];

    fontconfig.defaultFonts.emoji = [ "Noto Color Emoji" ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  console.useXkbConfig = true;

  stdenv.hostPlatform.system.stateVersion = "25.11";
}
