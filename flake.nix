{
  description = "NixOS + Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spotatui = {
      url = "github:LargeModGames/spotatui";
      flake = false;
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      happ-proxy = pkgs.stdenv.mkDerivation rec {
        pname = "happ";
        version = "2.5.2";
        src = pkgs.fetchurl {
          url = "https://github.com/Happ-proxy/happ-desktop/releases/download/2.5.2/Happ.linux.x64.deb";
          sha256 = "1mzz6naj7463qf71i1h93x2hzl2a5whypd0d2yni5jlvrsqa043z";
        };
        nativeBuildInputs = with pkgs; [
          dpkg
          autoPatchelfHook
          makeWrapper
        ];
        buildInputs = with pkgs; [
          glibc
          gcc-unwrapped
          webkitgtk_4_1
          gtk3
          libayatana-appindicator
          libsecret
        ];
        unpackPhase = "dpkg-deb -x $src .";
        installPhase = ''
          mkdir -p $out/bin $out/share
          cp -r usr/bin/* $out/bin/
          cp -r usr/share/* $out/share/
        '';
      };
    in
    {
      nixosConfigurations.nevernix = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs happ-proxy; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.never = import ./home.nix;
              backupFileExtension = "hm-bak";
              extraSpecialArgs = {
                inherit inputs happ-proxy;
              };
            };
          }
        ];
      };
    };
}
