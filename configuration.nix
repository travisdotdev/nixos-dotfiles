{ config, lib, pkgs, ... }:

{
  imports =
    [       
        ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.getty.autologinUser = "zena";
  console.keyMap = "uk";

  networking.hostName = "zena";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Dublin";

  programs.hyprland = {
  	enable = true;
	xwayland.enable = true;
  };

  users.users.zena= {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    wget
    git
	bluetuith
	pulseaudio
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
	noto-fonts
	noto-fonts-color-emoji
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nix.gc = {
	  automatic = true;
	  dates = "weekly";
	  options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	wireplumber.extraConfig."10-bluez" = {
	  "monitor.bluez.properties" = {
        "bluez5.roles" = [ "a2dp_sink" "hfp_hf" ];
        "bluez5.enable-sbc-xq" = true;
        "bluez5.hfphsp-backend" = "native";
      };
    };
  };

    hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
	settings.General = {
	  Experimental = true;   # battery % reporting for headsets/mice
	  FastConnectable = true;
	};
  };

  hardware.enableRedistributableFirmware = true;  # Intel/Realtek/MediaTek blobs

  system.stateVersion = "26.05";
}
