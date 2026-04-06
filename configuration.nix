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
    initrd.availableKernelModules = [
      "i2c_hid_acpi"
      "i2c_hid"
    ];

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
      kitty
      git
      v2ray-geoip
      v2ray-domain-list-community
      papirus-icon-theme
      kdePackages.qt6ct
      # winboat
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

    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        hplip
        splix
      ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    udev.extraRules = ''
      ACTION=="add|change", SUBSYSTEM=="input", ATTRS{id/vendor}=="2808", ATTRS{id/product}=="0106", ENV{ID_INPUT_MOUSE}="0", ENV{ID_INPUT_TOUCHPAD}="1"
    '';
  };

  networking = {
    hostName = "nevernix";
    networkmanager.enable = true;
    firewall = {
      enable = false;
      allowedTCPPorts = [ 631 ];
      allowedUDPPorts = [ 631 ];
    };
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
      corefonts
      vista-fonts
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

  system.stateVersion = "25.11";
}
