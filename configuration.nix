{ config, lib, pkgs, ... }:
{
  imports =
    [       
        ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.systemd-boot.editor = false;
  console.keyMap = "uk";
  networking.hostName = "zena";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Dublin";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.zena = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      tree
    ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
	builtins.elem (lib.getName pkg) [
	  "obsidian"
      "steam"
      "steam-unwrapped"
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "JetBrainsMono Nerd Font";
    })
	bluetui
	usbutils
	man-pages
	man-pages-posix
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.iosevka
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;

  security.rtkit.enable = true;
  security.pam.services.hyprlock = {};

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
	wireplumber.extraConfig."51-bluez-roles" = {
	  "monitor.bluez.properties" = {
	    "bluez5.roles" = [ "a2dp_source" "hsp_ag" "hfp_ag"];
		};
	};
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha-mauve";
  };
  services.displayManager.defaultSession = "hyprland";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  hardware.enableRedistributableFirmware = true;
  documentation.dev.enable = true;

  zramSwap = {
		enable = true;
		memoryPercent = 50;
  };

  services.earlyoom = {
		enable = true;
		freeMemThreshold = 5;
  };

  services.tailscale = {
	  enable = true;
	  useRoutingFeatures = "client";
  };

  programs.steam = {
	enable = true;
	remotePlay.openFirewall = true;
	localNetworkGameTransfers.openFirewall = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      gmp
      zlib
      libffi
      ncurses
      stdenv.cc.cc.lib
    ];
  };
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [ thunar-volman ];
  };
  services.gvfs.enable = true;     # trash, USB drives
  services.tumbler.enable = true;  # thumbnails
  programs.dconf.enable = true;    # needed for the GTK theme below

  system.stateVersion = "26.05";
}
