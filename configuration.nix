{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    # ./modules/hardware/additional-config.nix
    # ./modules/mangowc.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "xt_TPROXY" ];
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
      # zapret
    ];

    systemPackages = [
      inputs.tgt.packages.${pkgs.system}.default
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };

  services = {
    getty.autologinUser = "never";

    blueman.enable = true;

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

    mango.enable = true;

    #   dms-shell = {
    #     enable = true;
    #     systemd = {
    #       enable = true;
    #     };
    #   };

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
      "input"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  fonts.packages = with pkgs; [
    roboto
    nerd-fonts.jetbrains-mono
  ];

  security.polkit.enable = true;

  console.useXkbConfig = true;

  system.stateVersion = "25.11";
}
