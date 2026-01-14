{ pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;

    settings = {
      monitor = [
        "eDP-1,2880x1800@120,0x0,1"
        "HDMI-A-1,3840x2160@60,2880x0,1"
      ];

      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";
      "$mainMod" = "SUPER";

      env = [
        "XCURSOR_SIZE,18"
        "SDL_VIDEODRIVER,wayland"
        "NIXOS_OZONE_WL,1"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 15;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
        border_size = 1;
        "col.active_border" = "rgba(333333ff)";
        "col.inactive_border" = "rgba(00000000)";
      };

      render = {
        direct_scanout = false;
      };

      decoration = {
        rounding = 10;
        active_opacity = 0.9;
        inactive_opacity = 0.8;
        fullscreen_opacity = 0.9;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          new_optimizations = "on";
          ignore_opacity = true;
          xray = true;
        };

        shadow = {
          enabled = false;
          range = 10;
          render_power = 2;
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
        "$mainMod, V, togglefloating,"
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
      ]
      ++ (map (n: "$mainMod, ${toString n}, workspace, ${toString n}") [
        1
        2
        3
        4
        5
        6
        7
        8
        9
        0
      ])
      ++ (map (n: "$mainMod SHIFT, ${toString n}, movetoworkspace, ${toString n}") [
        1
        2
        3
        4
        5
        6
        7
        8
        9
        0
      ]);

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

      windowrulev2 = [
        "float,class:^(KittyRunner)$"
        "noborder, class:^(org\\.wezfurlong\\.wezterm)$"
        "noborder, class:^(Alacritty)$"
        "noborder, class:^(zen)$"
        "noborder, class:^(com\\.mitchellh\\.ghostty)$"
        "noborder, class:^(kitty)$"
        "float, class:^(firefox)$, title:^(Picture-in-Picture)$"
        "float, class:^(zoom)$"
        "float, class:^(org.quickshell)$"
        "opacity 0.9 0.9, floating:0, focus:0"
      ];

      "exec-once" = [
        "dms run"
        # "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
    };
  };
}
