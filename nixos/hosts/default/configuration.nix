# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  nixpkgs.config = {
    pulseaudio = true;
    # Duplicated from home.nix, is it ok?
    allowUnfree = true;
    permittedInsecurePackages = [
      # FIXME!
      "electron-25.9.0"
    ];
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
      ./hardware-configuration.nix
      ./main-user.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.extraEntries = ''
    menuentry "Windows 11" {
      chainloader (hd0,3)+1
    }
  '';

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

  programs.zsh.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      fmgordillo = {
        isNormalUser = true;
        description = "Facundo Martin Gordillo";
        extraGroups = [ "networkmanager" "audio" "wheel" "docker" ];
        packages = with pkgs; [
          brave
          neovim
        ];
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    appimage-run
    acpi
    autorandr # Multiple monitor manager?
    brightnessctl # Control brightness in laptop
    direnv
    fd # A simple, fast and user-friendly alternative to find
    feh # Wallpaper manager
    fzf
    git
    keybase # GPG keys
    lxappearance # Change theme and icons for i3
    neocomp # Composition for X11?
    nerdfonts
    nix-direnv
    pavucontrol # Audio manager?
    ripgrep
    rofi # Show i3 apps
    rofimoji # Show emojis like i3 apps
    unzip # Some packages needed it. >:c
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

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
    enableSSHSupport = true;
  };


  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      "fmgordillo" = import ./home.nix;
    };
  };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.trezord.enable = true;
  services.keybase.enable = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
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
