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
      };

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, space, exec, dms ipc call spotlight toggle"
        "$mainMod, v, exec, dms ipc call clipboard toggle"
        "$mainMod, m, exec, dms ipc call processlist focusortoggle"
        "$mainMod, comma, exec, dms ipc call settings focusortoggle"
        "$mainMod, n, exec, dms ipc call notifications toggle"
        "$mainMod shift, n, exec, dms ipc call notepad toggle"
        "$mainMod, y, exec, dms ipc call dankdash wallpaper"
        "$mainMod, tab, exec, dms ipc call hypr toggleoverview"
        "$mainMod SHIFT, Slash, exec, dms ipc call keybinds toggle hyprland"
        "$mainMod SHIFT, P, dpms, toggle"
        "$mainMod SHIFT, C, exec, hyprctl dispatch togglefloating && hyprctl dispatch centerwindow"
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

        "$maiMod SHIFT, left, movewindow, l"
        "$maiMod SHIFT, right, movewindow, r"
        "$maiMod SHIFT, up, movewindow, u"
        "$maiMod SHIFT, down, movewindow, d"
        #       "$maiMod SHIFT, h, movewindow, l"
        #       "$maiMod SHIFT, j, movewindow, d"
        #       "$maiMod SHIFT, k, movewindow, u"
        #       "$maiMod SHIFT, l, movewindow, r"

        "$maiMod ALT, left, moveactive,  -80 0"
        "$maiMod ALT, right, moveactive, 80 0"
        "$maiMod ALT, up, moveactive, 0 -80"
        "$maiMod ALT, down, moveactive, 0 80"
        #       "$maiMod ALT, h, moveactive,  -80 0"
        #       "$maiMod ALT, j, moveactive, 0 80"
        #       "$maiMod ALT, k, moveactive, 0 -80"
        #       "$maiMod ALT, l, moveactive, 80 0"
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

      windowrule = [
        #       "float, class:^(firefox)$, title:^(Picture-in-Picture)$"
        #       "float, class:^(zoom)$"
        #       "float, class:^(org.quickshell)$"
        #       "opacity 0.9 0.9, floating:0, focus:0"
      ];

      "exec-once" = [
        "dms run"
        "kitty zsh -c 'fastfetch; exec zsh'"
        # "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
    };

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
      inputs.hypr-dynamic-cursors.packages.${pkgs.stdenv.hostPlatform.system}.hypr-dynamic-cursors
      inputs.hyprgrass.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    extraConfig = ''
      plugin {
        hyprbars {
          bar_height = 27
          bar_color = rgba(1a1a1aaa)

          hyprbars-button = rgb(ff4040), 13, 󰧞, hyprctl dispatch killactive
          hyprbars-button = rgb(00ff00), 13, 󰧞, hyprctl dispatch movetoworkspacesilent special:minimized
          hyprbars-button = rgb(eeee11), 13, 󰧞, hyprctl dispatch fullscreen 1

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

        touch_gestures {
          sensitivity = 4.0
          workspace_swipe_fingers = 3
          workspace_swipe_edge = d
          long_press_delay = 400
          resize_on_border_long_press = true
          edge_margin = 10
         }
      }
    '';
  };
}
