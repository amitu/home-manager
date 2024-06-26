{ config, pkgs, ... }:
let
  my-email = "upadhyay@gmail.com";
  my-name = "Amit Upadhyay";
in {

  home = {
    username = "amitu";
    homeDirectory = "/Users/${config.home.username}";
    stateVersion = "23.05"; # Please read the comment before changing.
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      # permittedUnfreePackages = [ "vscode-1.79.2" ];
    };
  };

  home.packages = with pkgs; [
    bottom
    vscode
    ripgrep
    # devbox : Decided not to use it
    bat
    rustup
    postgresql
    nixfmt
    tig
    brotli
    tokei
    heroku
    # youtube-dl -> does not work on my machine!
    zellij
    difftastic
    # Set Terminal.app Font to Fira etc: especially for starship special prompts
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })

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

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraConfig = ''
      set number
      set number relativenumber
    '';
    plugins = with pkgs.vimPlugins; [
      ctrlp
      nerdtree
      tabular
      vim-nix
      vim-markdown
    ];
  };

  programs.git = {
    enable = true;
    userName = my-name;
    userEmail = my-email;
    extraConfig = {
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      pull.rebase = true;
      # use `git diff --no-ext-diff` if you want default output
      diff.external = "difft";
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
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
    EDITOR = "nvim";
    SPACESHIP_EXEC_TIME_ELAPSED=1;
    SPACESHIP_EXEC_TIME_PRECISION=3;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.broot = { enable = true; };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      cat = "bat";
      f = "fuck";
      nix-gc = "nix-collect-garbage -d";
      hm = "home-manager switch && exec zsh";
      zhm = "z ~/.config/home-manager";

      hmu = "nix-channel --update && home-manager switch && exec zsh";
    };
    initExtra = ''
      . "$HOME/.cargo/env"
      # eval $(thefuck --alias)
      export WASMTIME_HOME="$HOME/.wasmtime"
      export PATH="$WASMTIME_HOME/bin:$PATH:$HOME/bin:$HOME/.nix-profile/bin"
      export PATH=$PATH:"/Applications/Sublime Text.app/Contents/SharedSupport/bin"
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "rust" ];
      theme = "robbyrussell";
    };
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      line_break.disabled = true;
      add_newline = false;

      git_status = {
        stashed = "";
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
      };

      python.disabled = true;
      package.disabled = true;
      nodejs.disabled = true;
      rust.disabled = true;
      nix_shell.disabled = true;

      cmd_duration = {
        min_time = 0;
        show_milliseconds = true;
      };

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
