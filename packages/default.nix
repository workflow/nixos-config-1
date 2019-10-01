{ pkgs, ... }:

let

  # apps
  emacs = pkgs.callPackage ./emacs { };

  # tools
  nixfmt = pkgs.callPackage ./tools/nixfmt.nix { };
  pydf = pkgs.callPackage ./tools/pydf.nix { };

  # scripts
  kbconfig = pkgs.callPackage ./scripts/kbconfig.nix { };

  customPackages = [
    # apps
    emacs
    # tools
    nixfmt
    pydf
    # scripts
    kbconfig
  ];

in {
  imports = [ ./tools/tmux.nix ./haskell ./docker ];

  environment.variables.EDITOR = "vim";

  environment.systemPackages = [
    pkgs.ag
    pkgs.bat
    pkgs.fzf
    pkgs.git
    pkgs.htop
    pkgs.rofi
    pkgs.tree
    pkgs.vim
    pkgs.wget
    pkgs.gnumake
    pkgs.binutils-unwrapped
    pkgs.acpilight
    pkgs.playerctl
    pkgs.scrot

    pkgs.google-chrome
    pkgs.spotify
    pkgs.dropbox

    pkgs.gnome3.gnome-terminal
    pkgs.gnome3.nautilus
    pkgs.gnome3.gedit
    pkgs.i3lock-fancy
    pkgs.powertop
    pkgs.redshift

    pkgs.nix-prefetch-git
    pkgs.cachix
  ] ++ customPackages;
}
