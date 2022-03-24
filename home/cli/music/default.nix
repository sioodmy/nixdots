{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ mpc_cli playerctl ];

  services.mpd = {
    enable = true;
    # dataDir = "/home/sioodmy/.config/mpd";
    network = {
      listenAddress = "any";
      port = 6600;
    };
    extraConfig = ''
      audio_output {
        type    "pipewire"
        name    "pipewire"
      }
      auto_update "yes"
    '';
  };

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp;
    settings = {
      ncmpcpp_directory = "/home/sioodmy/.config/ncmpcpp";
      mpd_crossfade_time = 2;
      lyrics_directory = "/home/sioodmy/.cache/lyrics";
      progressbar_look = "▃▃▃";
      progressbar_elapsed_color = 5;
      progressbar_color = "black";
      media_library_primary_tag = "album_artist";
      follow_now_playing_lyrics = "yes";
      screen_switcher_mode = "playlist, media_library";
      song_columns_list_format = "(50)[]{t|fr:Title} (0)[magenta]{a}";
      song_list_format = " {%t $R   $8%a$8}|{%f $R   $8%l$8} $8";
      song_status_format =
        "$b$6$7[$8      $7]$6 $2 $7{$8 %b }|{$8 %t }|{$8 %f }$7 $8";
      song_window_title_format = "Now Playing ..";
      now_playing_prefix = "$b$2$7 ";
      now_playing_suffix = "  $/b$8";
      current_item_prefix = "$b$7$/b$3 ";
      current_item_suffix = "  $8";
      statusbar_color = "white";
      color1 = "white";
      color2 = "blue";
      header_visibility = "no";
      statusbar_visibility = "yes";
      titles_visibility = "no";
      enable_window_title = "yes";
      cyclic_scrolling = "yes";
      mouse_support = "yes";
      mouse_list_scroll_whole_page = "yes";
      lines_scrolled = "1";
      message_delay_time = "1";
      playlist_shorten_total_times = "yes";
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      search_engine_display_mode = "columns";
      playlist_editor_display_mode = "columns";
      autocenter_mode = "yes";
      centered_cursor = "yes";
      user_interface = "classic";
      locked_screen_width_part = "50";
      ask_for_locked_screen_width_part = "yes";
      display_bitrate = "no";
      external_editor = "nvim";
      main_window_color = "default";
      startup_screen = "playlist";

    };
  };
}
