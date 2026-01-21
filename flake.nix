{
  description = "NixOS + Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

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

    zapret-discord-youtube = {
      url = "github:kartavkun/zapret-discord-youtube";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mangowc = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      zapret-discord-youtube,
      mangowc,
      mango,
      ...
    }@inputs:
    {
      nixosConfigurations.nevernix = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          { nixpkgs.config.allowUnfree = true; }
          home-manager.nixosModules.home-manager
          mangowc.nixosModules.mango
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.never = import ./home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit inputs;
              };
              sharedModules = [
                mangowc.homeManagerModules.mango
              ];
            };
          }
          zapret-discord-youtube.nixosModules.default
          {
            services.zapret-discord-youtube = {
              enable = false;
              config = "general(ALT)";
            };
          }
        ];
      };
    };
}
