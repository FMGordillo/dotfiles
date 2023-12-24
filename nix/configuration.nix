# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
	nixpkgs.config = {
	pulseaudio = true;
	allowUnfree = true;
};

hardware = {
	enableAllFirmware = true;
	pulseaudio = {
		enable = true;
		package = pkgs.pulseaudioFull;
		# Support for virtual input/output
		extraConfig = "load-module module-combine-sink";
	};
	bluetooth = {
		enable = true;
	};
};

sound.enable = true;

imports =
[
	# Include the results of the hardware scan.
	./hardware-configuration.nix
];


# Bootloader.
/*
boot.loader.grub.enable = true;
boot.loader.grub.efiSupport = true;
boot.loader.grub.device = "nodev";
boot.loader.efi.canTouchEfiVariables = true;
boot.loader.efi.efiSysMountPoint = "/boot/efi";
boot.loader.grub.useOSProber = true;
*/

networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
networking.networkmanager.enable = true;

# Set your time zone.
time.timeZone = "Europe/Madrid";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";

i18n.extraLocaleSettings = {
	LC_ADDRESS = "es_ES.UTF-8";
	LC_IDENTIFICATION = "es_ES.UTF-8";
	LC_MEASUREMENT = "es_ES.UTF-8";
	LC_MONETARY = "es_ES.UTF-8";
	LC_NAME = "es_ES.UTF-8";
	LC_NUMERIC = "es_ES.UTF-8";
	LC_PAPER = "es_ES.UTF-8";
	LC_TELEPHONE = "es_ES.UTF-8";
	LC_TIME = "es_ES.UTF-8";
};

# Setup i3
services.xserver = {
	enable = true;
	desktopManager = {
		xterm.enable = false;
	};
	displayManager = {
		defaultSession = "none+i3";
	};
	windowManager = {
		i3 = {
			enable = true;
			extraPackages = with pkgs; [
				dmenu # app launcher
				i3blocks
				i3lock-color
				i3status
			];
		};
	};
};

virtualisation.docker = {
	enable = true;
	rootless = {
		enable = true;
		setSocketVariable = true;
	};
};

# Define a user account. Don't forget to set a password with ‘passwd’.
users = {
	defaultUserShell = pkgs.zsh;
	users = {
		fmgordillo = {
			isNormalUser = true;
			description = "Facundo Martin Gordillo";
			extraGroups = [ "networkmanager" "audio" "wheel" "docker" ];
			packages = with pkgs; [
				appimage-run			# Run AppImage
				audacity				# Audio recording
				bat						# Replacement of 'cat'
				bitwig-studio			# Audio production
				brave
				chromium
				discord
				eza
				firefox-devedition
				flameshot				# Screenshots
				gimp					# Photo editor
				jq						# JSON Formatter
				kate					# Tiny IDE
				kitty					# Terminal manager
				lazygit
				obs-studio
				obsidian
				pcmanfm					# File manager
				peek					# Screen video capture
				python3
				redshift				# Screen color temperature manager
				spotifyd
				synology-drive-client
				teamviewer
				trash-cli				# safe rm
				vlc
				xclip					# Clipboard
				zsh-powerlevel10k		# ZSH Theme
			];
		};
	};
};

# List packages installed in system profile. To search, run:
# $ nix search wget
environment.systemPackages = with pkgs; [
	appimage-run
	acpi
	autorandr		# Multiple monitor manager?
	brightnessctl	# Control brightness in laptop
	direnv
	fd				# A simple, fast and user-friendly alternative to find
	feh				# Wallpaper manager
	fzf
	git
	keybase			# GPG keys
	lxappearance	# Change theme and icons for i3
	neocomp			# Composition for X11?
	nerdfonts
	nix-direnv
	pavucontrol		# Audio manager?
	ripgrep
	rofi			# Show i3 apps
	rofimoji		# Show emojis like i3 apps
	unzip			# Some packages needed it. >:c
	zig
];

fonts = {
	enableDefaultPackages = true;
	packages = with pkgs; [
		ibm-plex
		ubuntu_font_family
		(nerdfonts.override { fonts = [ "CascadiaCode" ]; })
	];
};

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

programs.neovim = {
	enable = true;
};

services.pcscd.enable = true;
programs.gnupg.agent = {
	enable = true;
	pinentryFlavor = "gtk2";
	enableSSHSupport = true;
};

programs.zsh = {
	enable = true;
	histSize = 10000;
	syntaxHighlighting = {
		enable = true;
	};
	autosuggestions = {
		enable = true;
	};
	shellAliases = {
		bright = "brightnessctl";
		cat = "bat";
		fix_pinentry = "pkill -f gpg-agent; pkill -f pinentry && systemctl --user restart gpg-agent{.socket,-extra.socket,-ssh.socket}";
		ls = "eza";
		rm = "echo 'This is not the command you are looking for.'; false";
		update = "sudo nixos-rebuild switch";
	};
	ohMyZsh = {
		enable = true;
		plugins = [ "git" "direnv" "fzf" "vi-mode" ];
	};
	interactiveShellInit = ''
		source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
		source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/direnv/direnv.plugin.zsh
		source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/fzf/fzf.plugin.zsh
		source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/vi-mode/vi-mode.plugin.zsh
	'';
};


# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;
services.trezord.enable = true;
services.keybase.enable = true;

nix = {
	extraOptions = ''experimental-features = nix-command'';
	settings = {
		keep-outputs = true;
		keep-derivations = true;
	};
};

# X11 Composition, not more tearing!
# Currently not working
systemd.user.services.neocomp = {
	description = "X11 Neocomp";
	serviceConfig.PassEnvironment = "DISPLAY";
	script = ''
		neocomp
	'';
	wantedBy = [ "multi-user.target" ]; # starts after login
};

environment.pathsToLink = [ "/share/nix-direnv" ];

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "23.05"; # Did you read the comment?
}
