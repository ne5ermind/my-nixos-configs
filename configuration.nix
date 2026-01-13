{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/hardware/additional-config.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nevernix";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Moscow";
  services.getty.autologinUser = "never";

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

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cpu;
    loadModels = [
      "qwen2.5:3b"
    ];
  };

  programs = {
    # firefox.enable = true;

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

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

  environment.systemPackages = with pkgs; [
    wget
    waybar
    kitty
    git
  ];

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

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.11";
}
