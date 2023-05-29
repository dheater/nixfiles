{ config, pkgs, ... }:

{
  home.username = "dheater";
  home.homeDirectory = "/home/dheater";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

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

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dheater/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;[
    alacritty
    antigen
    bat
    emacs
    exa
    fzf
    helix
    jq
    nix
    openssh
    tmux
    unzip
    vim
    wget
    zellij
    zoxide
    zsh
  ];

  programs = {
    git = {
      enable = true;
      userName = "dheater";
      userEmail = "dheater@users.noreply.github.com";
      
      extraConfig = {
        # Sign all commits using ssh key
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id-dheater.pub";
      };
    };
  };

  # bin
  home.file.".config/bin".source = ./bin;

  # config
  home.file.".config/alacrity".source = .config/alacritty;
  home.file.".config/helix".source = .config/helix;
  home.file.".config/zellij".source = .config/zellij;

  # zsh
  home.file.".zsh_plugins.txt".source = zsh/.zsh_plugins.txt;
  home.file.".zshrc".source = ./zsh/.zshrc;
}