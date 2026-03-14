{ pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    settings = {
      monitor = [
        "eDP-1,2880x1800@120,0x0,1"
        "HDMI-A-1,3840x2160@60,2880x0,1"
      ];

      "$terminal" = "kitty";
      "$mainMod" = "SUPER";

      env = [
        "XCURSOR_SIZE,18"
        "SDL_VIDEODRIVER,wayland"
        "NIXOS_OZONE_WL,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "CLUTTER_BACKEND,wayland"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 15;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
        border_size = 2;
        "col.active_border" = "rgba(333333aa)";
        "col.inactive_border" = "rgba(1a1a1aaa)";
      };

      decoration = {
        rounding = 20;
        active_opacity = 1;
        inactive_opacity = 0.8;
        fullscreen_opacity = 1;

        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          new_optimizations = "on";
          ignore_opacity = true;
          xray = true;
        };

        shadow = {
          enabled = false;
          range = 10;
          render_power = 4;
          color = "0x33000000";
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];

        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      scrolling = {
        column_width = 0.8;
        focus_fit_method = 0;
        fullscreen_on_one_column = false;
        follow_min_visible = 0.7;
      };

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle,caps:escape";
        follow_mouse = 1;
        sensitivity = -0.3;
        touchpad = {
          natural_scroll = false;
          disable_while_typing = true;
        };
      };

      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        initial_workspace_tracking = 1;
        middle_click_paste = false;
      };

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod SHIFT, C, forcekillactive,"
        "$mainMod, V, togglefloating"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod SHIFT, V, exec, hyprctl dispatch centerwindow"

        # switching layouts
        "$mainMod, M, exec, hyprctl keyword general:layout master"
        "$mainMod, D, exec, hyprctl keyword general:layout dwindle"
        "$mainMod, S, exec, hyprctl keyword general:layout scrolling"

        # move focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        "$mainMod, M, togglespecialworkspace, magic"
        "$mainMod SHIFT, M, movetoworkspace, special:magic"

        # dms controls
        "$mainMod, space, exec, dms ipc call spotlight toggle"
        "$mainMod ALT, v, exec, dms ipc call clipboard toggle"
        "$mainMod, m, exec, dms ipc call processlist focusortoggle"
        "$mainMod, comma, exec, dms ipc call settings focusortoggle"
        "$mainMod, n, exec, dms ipc call notifications toggle"
        "$mainMod shift, n, exec, dms ipc call notepad toggle"
        "$mainMod, y, exec, dms ipc call dankdash wallpaper"
        "$mainMod SHIFT, Slash, exec, dms ipc call keybinds toggle hyprland"
        "$mainMod SHIFT, P, dpms, toggle"

        # navigating workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # moving windows between workspaces
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, j, movewindow, d"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, l, movewindow, r"

        "$mainMod ALT, left, moveactive,  -80 0"
        "$mainMod ALT, right, moveactive, 80 0"
        "$mainMod ALT, up, moveactive, 0 -80"
        "$mainMod ALT, down, moveactive, 0 80"
        "$mainMod ALT, h, moveactive,  -80 0"
        "$mainMod ALT, j, moveactive, 0 80"
        "$mainMod ALT, k, moveactive, 0 -80"
        "$mainMod ALT, l, moveactive, 80 0"

        # scrolling layout
        "$mainMod ALT, h, layoutmsg, swapcol l"
        "$mainMod ALT, l, layoutmsg, swapcol r"
        "$mainMod, U, layoutmsg, colresize +0.1"
        "$mainMod, D, layoutmsg, colresize -0.1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      gesture = [
        "3, horizontal, workspace"
        "3, vertical, dispatcher, exec, pypr expose"
      ];

      gestures = {
        workspace_swipe_distance = 300;
      };

      exec-once = [
        "dms run"
        "kitty zsh -c 'fastfetch; exec zsh'"
        "${pkgs.pyprland}/bin/pypr"
      ];
    };

    #   plugins = [
    #     inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
    #     inputs.hypr-dynamic-cursors.packages.${pkgs.stdenv.hostPlatform.system}.hypr-dynamic-cursors
    #     inputs.hyprspace.packages.${pkgs.system}.Hyprspace
    #   ];

    extraConfig = ''
      plugin {
        hyprbars {
          bar_height = 27
          bar_color = rgba(1a1a1aaa)

          hyprbars-button = rgb(ff4040), 13, 󰧞, hyprctl dispatch killactive
          hyprbars-button = rgb(eeee11), 13, 󰧞, hyprctl dispatch movetoworkspacesilent special:minimized
          hyprbars-button = rgb(00ff00), 13, 󰧞, hyprctl dispatch fullscreen 1

          bar_title_enabled = true
          bar_part_of_window = true
          bar_precedence_over_border = true
          bar_buttons_alignment = left
          bar_button_padding = 10
          bar_padding = 20

          col.text = rgb(ffffff)
          bar_text_font = JetBrainsMono Nerd Font
          bar_text_size = 11
        }

        dynamic-cursors {
          enabled = true
          mode = shake

          shake {
            enabled = true
            nearest = true
            threshold = 6.0
            base = 4.0
            speed = 4.0
            influence = 0.0
            limit = 0.0
            timeout = 1000
            effects = false
            ipc = false
          }
        }


        overview {
          panelHeight = 150
          panelBorderWidth = 2
          workspaceMargin = 5
        }
      }

      workspace = special:exposed,gapsout:60,gapsin:30,bordersize:2,border:true,shadow:false
      workspace = 1, layout:scrolling
      workspace = 2, layout:scrolling
      workspace = 9, layout:scrolling, layoutopt:direction:up
      workspace = 10, layout:master
    '';
  };
}
