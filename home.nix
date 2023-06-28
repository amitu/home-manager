{ config, pkgs, ... }:

{
  home.username = "amitu";
  home.homeDirectory = "/Users/amitu";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    bottom
    fish
    heroku
    thefuck
    ripgrep
    devbox
    bat

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

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/amitu/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      cat = "bat";
      f = "fuck";
      hm = "home-manager switch";
      hmu = "nix-channel --update && home-manager switch";
    };
    initExtra = ''
      . "$HOME/.cargo/env"
      export WASMTIME_HOME="$HOME/.wasmtime"
      export PATH="$WASMTIME_HOME/bin:$PATH:$HOME/bin"
      export PATH=$PATH:"/Applications/Sublime Text.app/Contents/SharedSupport/bin"
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "rust" ];
      theme = "robbyrussell";
    };
  };


  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
