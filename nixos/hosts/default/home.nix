{ config, lib, pkgs, ... }: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fmgordillo";
  home.homeDirectory = "/home/fmgordillo";

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      # FIXME!
      "electron-25.9.0"
    ];
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    audacity # Audio recording
    bat # Replacement of 'cat'
    bitwig-studio # Audio production
    brave
    chromium
    discord
    eza
    firefox-devedition
    flameshot # Screenshots
    gimp # Photo editor
    jq # JSON Formatter
    kitty # Terminal manager
    lazygit
    obs-studio
    obsidian
    peek # Screen video capture
    redshift # Screen color temperature manager
    spotifyd
    synology-drive-client
    teamviewer
    trash-cli # safe rm
    vlc
    xclip # Clipboard
    zsh-powerlevel10k
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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

  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraLuaConfig = ''
        local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        if not vim.loop.fs_stat(lazypath) then
          -- bootstrap lazy.nvim
          -- stylua: ignore
          vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
        end
        vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

        require("lazy").setup({
          spec = {
            -- add LazyVim and import its plugins
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            -- import any extras modules here
            -- { import = "lazyvim.plugins.extras.lang.typescript" },
            -- { import = "lazyvim.plugins.extras.lang.json" },
            -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
            -- import/override with your plugins
            { import = "plugins" },
          },
          defaults = {
            -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
            -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
            lazy = false,
            -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
            -- have outdated releases, which may break your Neovim install.
            version = false, -- always use the latest git commit
            -- version = "*", -- try installing the latest stable version for plugins that support semver
          },
          install = { colorscheme = { "tokyonight", "habamax" } },
          checker = { enabled = true }, -- automatically check for plugin updates
          performance = {
            rtp = {
              -- disable some rtp plugins
              disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
              },
            },
          },
        })
        			'';
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      dotDir = ".config/zsh";

      #histSize = 10000;
      syntaxHighlighting = {
        enable = true;
      };
      shellAliases = {
        bright = "brightnessctl";
        cat = "bat";
        fix_pinentry = "pkill -f gpg-agent; pkill -f pinentry && systemctl --user restart gpg-agent{.socket,-extra.socket,-ssh.socket}";
        ls = "eza";
        update = "sudo nixos-rebuild switch --flake /etc/nixos#default";
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

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
