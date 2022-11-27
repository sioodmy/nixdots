{
  config,
  lib,
  pkgs,
  ...
}: let
  cht = pkgs.writeShellScriptBin "cht" ''
    curl -s cht.sh/$(gum input --placeholder "Query" | tr " " "+") | bat --style=plain --paging=always
  '';
in {
  home.packages = [cht];
  programs.exa.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      scan_timeout = 5;
      character = {
        error_symbol = "[](bold red)";
        success_symbol = "[](bold green)";
        vicmd_symbol = "[](bold yellow)";
        format = "$symbol [|](bold bright-black) ";
      };
      git_commit = {commit_hash_length = 4;};
      line_break.disabled = false;
      lua.symbol = "[](blue) ";
      hostname = {
        ssh_only = true;
        format = "[$hostname](bold blue) ";
        disabled = false;
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    sessionVariables = {LC_ALL = "en_US.UTF-8";};
    completionInit = ''
      autoload -U compinit
      zstyle ':completion:*' menu select
      zmodload zsh/complist
      compinit
      _comp_options+=(globdots)
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey -v '^?' backward-delete-char
    '';
    initExtra = ''
      autoload -U url-quote-magic
      zle -N self-insert url-quote-magic
      setopt share_history
      export FZF_DEFAULT_OPTS="
      --color fg:#c6d0f5
      --color fg+:#51576d
      --color bg:#303446
      --color bg+:#303446
      --color hl:#8caaee
      --color hl+:#8caaee
      --color info:#626880
      --color prompt:#a6d189
      --color spinner:#8caaee
      --color pointer:#8caaee
      --color marker:#8caaee
      --color border:#626880
      --color header:#8caaee
      --prompt ' | '
      --pointer ''
      --layout=reverse
      --border horizontal
      --height 40
      "

      function run() {
        nix run nixpkgs#$@
      }

      command_not_found_handler() {
        printf 'Command not found ->\033[32;05;16m %s\033[0m \n' "$0" >&2
        return 127
      }
    '';
    history = {
      save = 1000;
      size = 1000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    dirHashes = {
      docs = "$HOME/docs";
      notes = "$HOME/docs/notes";
      dl = "$HOME/download";
      vids = "$HOME/vids";
      music = "$HOME/music";
      media = "/run/media/$USER";
    };

    shellAliases = {
      rebuild = "sudo nix-store --verify; sudo nixos-rebuild --install-bootloader switch --flake .#; bat cache --build";
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      nixtest = "sudo nixos-rebuild test --flake .#graphene --fast";
      bloat = "nix path-info -Sh /run/current-system";
      ytmp3 = ''
        ${pkgs.yt-dlp}/bin/yt-dlp -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
      cat = "${pkgs.bat}/bin/bat --style=plain";
      grep = "${pkgs.ripgrep}/bin/rg";
      du = "${pkgs.du-dust}/bin/dust";
      ps = "${pkgs.procs}/bin/procs";
      m = "mkdir -p";
      fcd = "cd $(find -type d | fzf)";
      ls = "${pkgs.exa}/bin/exa --icons --group-directories-first";
      la = "${pkgs.exa}/bin/exa -lah";
      tree = "${pkgs.exa}/bin/exa --tree --icons";
      http = "${pkgs.python3}/bin/python3 -m http.server";
      v = "nvim";
      ssh = "kitty +kitten ssh";
    };

    plugins = [
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };

  programs.git = {
    enable = true;
    userName = "sioodmy";
    userEmail = "hello@sioodmy.dev";
    extraConfig = {
      init = {defaultBranch = "main";};
      delta = {
        syntax-theme = "Nord";
        plus-style = "syntax #a6d189";
        minus-style = "syntax #e78284";
        line-numbers = true;
      };
    };
    lfs.enable = true;
    delta.enable = true;
    ignores = ["*~" "*.swp" "*result*" ".direnv" "node_modules"];
    aliases = {
      co = "checkout";
      fuck = "commit --amend -m";
      ca = "commit -am";
      d = "diff";
      ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
      pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
      af = "!git add $(git ls-files -m -o --exclude-standard | fzf -m)";
      st = "status";
      br = "branch";
      df = "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
      hist = ''
        log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all'';
      llog = ''
        log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative'';
      edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; vim `f`";
    };
  };
}
