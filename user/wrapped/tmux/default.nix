{pkgs, ...}: let
  plugins = ["vim-tmux-navigator" "sensible" "nord" "yank"];
  tmuxconf = pkgs.writeText "tmux.conf" ''
    set -g mouse on

    unbind C-b
    set -g prefix C-Space
    bind C-Space send-prefix

    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    # Start windows and panes at 1, not 0
    set -g base-index 1
    set -g pane-base-index 1
    set-window-option -g pane-base-index 1
    set-option -g renumber-windows on

    ${builtins.concatStringsSep "\n" (map (x: "run-shell ${pkgs.tmuxPlugins.${x}}/share/tmux-plugins/${x}.tmux") plugins)}

    # set vi-mode
    set-window-option -g mode-keys vi
    # keybindings
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

    bind '"' split-window -v -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"
  '';
in
  pkgs.symlinkJoin {
    name = "tmux-wrapped";
    paths = [pkgs.tmux];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/tmux --add-flags "-f ${tmuxconf}"
    '';
  }
