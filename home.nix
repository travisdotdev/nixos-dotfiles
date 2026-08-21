{ config, pkgs, ... }:


let 
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	configs = {
		hypr = "hypr";
		nvim = "nvim";
		waybar = "waybar";
		foot = "foot";
	};
in

{
    home.username = "zena";
    home.homeDirectory = "/home/zena";
    home.stateVersion = "26.05";

	programs.git = {
		enable = true;
		userName = "travdotdev";
		userEmail = "108806867+travisdotdev@users.noreply.github.com";
		extraConfig.credential."https://github.com".helper = "$[pkgs.gh]/bin/gh/ auth git-credential";
	};
	programs.bash = {
        enable = true;
        shellAliases = 
		{
            btw = "echo I use nixos, btw";
			rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#zena";
        };
	profileExtra = ''
		if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
			exec start-hyprland
		fi
	'';
    };

	xdg.configFile = builtins.mapAttrs (name: subpath: {
		source = create_symlink "${dotfiles}/${subpath}";
		recursive = true;
		})
	configs;
	home.pointerCursor = {
		gtk.enable = true;
		hyprcursor.enable = true;
		package = pkgs.bibata-cursors;
		name = "Bibata-Original-Classic";
		size = 17;
	};

	home.packages = with pkgs; [
		neovim
		ripgrep
		nil
		nixpkgs-fmt
		nodejs
		gcc
		fd
		gnumake
		unzip
		tree-sitter
		lua-language-server
		pyright
		clang-tools
		gdb
		(python3.withPackages (ps: with ps; [ debugpy pynvim ]))
		hyprshot
		wl-clipboard
		gh
		kitty
		waybar
		foot
		hyprpaper
		killall
	];
}
