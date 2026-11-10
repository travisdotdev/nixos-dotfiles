{ config, pkgs, ... }:


let 
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	configs = {
		hypr = "hypr";
		nvim = "nvim";
		waybar = "waybar";
		foot = "foot";
		fuzzel = "fuzzel";
		yazi = "yazi";
		mako = "mako";
		btop = "btop";
		fastfetch = "fastfetch";
	}; in
{
    home.username = "zena";
    home.homeDirectory = "/home/zena";
    home.stateVersion = "26.05";

	home.file.".stack/config.yaml".text = "nix:\n  enable: false\nsystem-ghc: true\ninstall-ghc: false\nnotify-if-nix-on-path: false\n";
	
    home.sessionPath = [ "$HOME/bin" "$HOME/.local/bin" ];

	programs.git = {
		enable = true;
		settings = {
			init.defaultBranch = "main";
			user.name = "travdotdev";
			user.email = "108806867+travisdotdev@users.noreply.github.com";
			credential."https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
			core.editor = "nvim";
		};
	};
	programs.bash = {
        enable = true;
        shellAliases = 
		{
            btw = "echo I use nixos, btw";
			rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#zena";
			run = "setsid -f";
			wayreload = "pkill -USR2 -f waybar";
			vpn-up  = "sudo tailscale up --login-server https://vpn-student.scss.tcd.ie --accept-routes";
			vpn-down = "sudo tailscale down";
			vpn-status = "tailscale status";
        };
	# profileExtra = ''
	# 	if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
	# 		exec start-hyprland
	# 	fi
	# '';
    };
	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
		enableBashIntegration = true;
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

	gtk = {
		enable = true;
		theme = {
			name = "Adwaita-dark";
			package = pkgs.gnome-themes-extra;
		};
		iconTheme = {
			name = "Papirus-Dark";
			package = pkgs.papirus-icon-theme;
		};
		gtk3.extraCss = ''
			@define-color gtk_bg #2b3438;
			@define-color gtk_fg #e0e7e9;

			window, .background, headerbar, .sidebar, .view, .titlebar,
			notebook, menu, .menu, popover, .toolbar, textview, textview text,
			treeview, treeview.view, treeview.view text,
			toolbar, toolbar *, menubar, menubar *, notebook * {
				background-color: @gtk_bg;
				background-image: none;
			}

			* { color: @gtk_fg; }

			.view:selected, .view selection, textview text selection,
			treeview.view:selected, treeview.view:selected:focus {
				background-color: #48575c;
				color: #e0e7e9;
			}
		'';
	};
	xdg.mimeApps = {
		enable = true;
		defaultApplications = {
			"inode/directory" = [ "thunar.desktop" ];

			"image/png"  = [ "feh.desktop" ];
			"image/jpeg" = [ "feh.desktop" ];
			"image/gif"  = [ "feh.desktop" ];
			"image/webp" = [ "feh.desktop" ];
			"image/bmp"  = [ "feh.desktop" ];

			"application/pdf" = [ "firefox.desktop" ];

			"text/plain"    = [ "nvim-foot.desktop" ];
			"text/markdown" = [ "nvim-foot.desktop" ];
		};
		associations.added = {
			"image/webp"      = [ "feh.desktop" ];
			"application/pdf" = [ "firefox.desktop" ];
		};
	};

	xdg.desktopEntries.nvim-foot = {
		name = "Neovim (foot)";
		exec = "foot nvim %F";
		terminal = false;
		mimeType = [ "text/plain" "text/markdown" ];
		noDisplay = true;
	};

	home.packages = with pkgs; [
		neovim
		ripgrep
		nil
		nixfmt
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
		kitty
		waybar
		foot
		psmisc
		fuzzel
		pavucontrol
		obsidian
		p7zip
		yazi
		ffmpegthumbnailer
		poppler-utils
		jq
		hyprlock
		hypridle
	    bluetuith
		pulseaudio
		brightnessctl
		direnv
		anki
		gh
		docker
		swi-prolog
		btop
		libreoffice
		feh
		mako
		libnotify
		playerctl
		(writeShellScriptBin "polkit-agent" "exec ${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent")
		fastfetch
		awww
		waypaper
	];
}
