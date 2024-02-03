{
  description = "NixOS & macOS configuration of Ryan Yin";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs @ {
    self,
    nixpkgs-unstable,
    nixpkgs-stable,
    ...
  }: let
    constants = import ./constants.nix {inherit inputs;};

    allSystemConfigurations = import ./systems {inherit self inputs constants;};
  in
    allSystemConfigurations;

  inputs = {
    # Official NixOS package source, using nixos's stable branch by default
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      # url = "github:nix-community/home-manager/release-23.11";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Secure boot - Review later
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.3.0";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.33.1";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # community wayland nixpkgs
    # nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    # anyrun - a wayland launcher
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nuenv.url = "github:DeterminateSystems/nuenv";

    # enables nixos in wsl
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    ########################  Some non-flake repositories  #########################################

    # doom-emacs is a configuration framework for GNU Emacs.desktop/base
    doomemacs = {
      url = "github:doomemacs/doomemacs";
      flake = false;
    };

    polybar-themes = {
      url = "github:adi1090x/polybar-themes";
      flake = false;
    };

    ########################  Color Schemes  #########################################

    # color scheme - catppuccin
    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };
    catppuccin-fcitx5 = {
      url = "github:catppuccin/fcitx5";
      flake = false;
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
    catppuccin-wezterm = {
      url = "github:catppuccin/wezterm";
      flake = false;
    };
    catppuccin-helix = {
      url = "github:catppuccin/helix";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    catppuccin-hyprland = {
      url = "github:catppuccin/hyprland";
      flake = false;
    };
    catppuccin-cava = {
      url = "github:catppuccin/cava";
      flake = false;
    };
    catppuccin-k9s = {
      url = "github:catppuccin/k9s";
      flake = false;
    };
    catppuccin-foot = {
      url = "github:catppuccin/foot";
      flake = false;
    };
    catppuccin-yazi = {
      url = "github:yazi-rs/themes";
      flake = false;
    };
    #------ Review later
    # https://github.com/virchau13/dots/blob/9eec548da8e72c5f2b41cdeb40e983dcc91aefd1/apps/nvim/default.nix#L7
    sentiment-nvim = {
      url = "github:utilyre/sentiment.nvim";
      flake = false;
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
    # flake-utils.url = github:numtide/flake-utils;
    # # eww = {
    #     url = github:elkowar/eww;
    # };
    neovim-nightly = {
      # https://github.com/neovim/neovim/blob/master/BUILD.md
      # url = "github:neovim/neovim?dir=contrib";
      url = "github:neovim/neovim/contrib";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      # inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    #
    #
  };

  # the nixConfig here only affects the flake itself, not the system configuration!
  # for more information, see:
  #     https://nixos-and-flakes.thiscute.world/nixos-with-flakes/add-custom-cache-servers
  nixConfig = {
    # substituers will be appended to the default substituters when fetching packages
    extra-substituters = [
      "https://anyrun.cachix.org"
      "https://hyprland.cachix.org"
      # "https://nixpkgs-wayland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };
}
