{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fmgordillo";
  home.homeDirectory = "/home/fmgordillo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    #pkgs.reaper
	pkgs.brave
	pkgs.discord
	pkgs.gimp
	pkgs.obs-studio
	pkgs.protonvpn-gui
	pkgs.ripgrep
	pkgs.xclip
    pkgs.ansible
    pkgs.audacity
    pkgs.bat
    pkgs.bitwig-studio
    pkgs.eza
    pkgs.lazygit
    pkgs.obsidian
    pkgs.spotifyd
    pkgs.tabnine
    pkgs.trash-cli
    pkgs.zig
    pkgs.zsh-powerlevel10k
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "UbuntuMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.nodejs
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.shellAliases = {
    bright = "brightnessctl";
    cat = "bat";
    fix_pinentry = "pkill -f gpg-agent; pkill -f pinentry && systemctl --user restart gpg-agent{.socket,-extra.socket,-ssh.socket}";
    ls = "eza";
    update = "home-manager switch";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fmgordillo/etc/profile.d/hm-session-vars.sh
  #

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "nvim";
    };
    initExtra = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
    '';
  };

  programs.neovim = {
    enable = true;
  };

  programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      dotDir = ".config/zsh";
      syntaxHighlighting = {
        enable = true;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "direnv" "fzf" "vi-mode"];
      };
      initExtra = ''
	[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/direnv/direnv.plugin.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/fzf/fzf.plugin.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/vi-mode/vi-mode.plugin.zsh
        				'';
      };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

  programs.git = {
    enable = true;
    userName = "FMGordillo";
    userEmail = "me@facundogordillo.com";
  };

  programs.direnv = {
      enable = true;
  };

  services = {
    keybase.enable = true;

    # TODO: Handle this correctly (see `man ssh-agent(1)`)
    ssh-agent.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
