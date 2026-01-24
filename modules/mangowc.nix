{
  wayland.windowManager.mango = {
    enable = true;
    settings = ''
      #Layout
      # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
      #Keys
      bind=SUPER,q,spawn,kitty
      bind=SUPER,c,killclient,
      bind=SUPER,z,spawn,zen

      bind=SUPER,h,focusdir,left
      bind=SUPER,j,focusdir,down
      bind=SUPER,k,focusdir,up
      bind=SUPER,l,focusdir,right

      bind=SUPER+SHIFT,h,exchange_client,left
      bind=SUPER+SHIFT,j,exchange_client,down
      bind=SUPER+SHIFT,k,exchange_client,up
      bind=SUPER+SHIFT,l,exchange_client,right

      bind=SUPER,1,comboview,1
      bind=SUPER,2,comboview,2
      bind=SUPER,3,comboview,3
      bind=SUPER,4,comboview,4
      bind=SUPER,5,comboview,5
      bind=SUPER,6,comboview,6
      bind=SUPER,7,comboview,7
      bind=SUPER,8,comboview,8
      bind=SUPER,9,comboview,9
      bind=SUPER,0,comboview,10

      bind=SUPER+SHIFT,1,tag,1
      bind=SUPER+SHIFT,2,tag,2
      bind=SUPER+SHIFT,3,tag,3
      bind=SUPER+SHIFT,4,tag,4
      bind=SUPER+SHIFT,5,tag,5
      bind=SUPER+SHIFT,6,tag,6
      bind=SUPER+SHIFT,7,tag,7
      bind=SUPER+SHIFT,8,tag,8
      bind=SUPER+SHIFT,9,tag,9
      bind=SUPER+SHIFT,0,tag,10

      bind=SUPER,y,spawn,dms ipc call dankdash wallpaper
      bind=SUPER,comma,spawn,dms ipc call settings focusortoggle
      bind=SUPER,space,spawn,dms ipc call spotlight toggle


      bind=SUPER,f,togglefullscreen,
      bind=SUPER+SHIFT,f,togglefloating,
      bind=SUPER+SHIFT,c,centerwin,

      bind=SUPER,t,setlayout,tile
      bind=SUPER,v,setlayout,vertical_grid
      bind=SUPER,c,setlayout,spiral
      bind=SUPER,x,setlayout,scroller
      bind=SUPER,n,switch_layout
      bind=SUPER,g,togglegaps
      bind=SUPER,s,toggleoverview


      bind=SUPER+SHIFT,r,reload_config

      bind=SUPER,m,incnmaster,+1
      bind=SUPER,n,incnmaster,-1

      cursor_size=15
      # monitors
      monitorrule=DP-1,0.55,1,scroller,0,1,0,0,2880,1800,120
      monitorrule=HDMI-A-1,0.50,1,tile,0,1,2880,0,3840,2160,60

      # theming
      bordercolor=0x44444444
      focuscolor=0x99999999
      borderpx=1
      border_radius=7
      blur=1
      blur_params_radius=3
      blur_params_passes=2

      animations=1
      layer_animations=1
      animation_type_open=zoom
      animation_type_close=slide 
      layer_animation_type_open=slide
      layer_animation_type_close=slide 
      animation_fade_in=1
      animation_fade_out=1
      tag_animation_direction=1
      zoom_initial_ratio=0.3
      zoom_end_ratio=0.7
      fadein_begin_opacity=0.6
      fadeout_begin_opacity=0.8
      animation_duration_move=500
      animation_duration_open=400
      animation_duration_tag=350
      animation_duration_close=800
      animation_curve_open=0.46,1.0,0.29,1.1
      animation_curve_move=0.46,1.0,0.29,1
      animation_curve_tag=0.46,1.0,0.29,1
      animation_curve_close=0.08,0.92,0,1

      bind=ALT,r,setkeymode,resize

      keymode=resize
      bind=NONE,h,resizewin,-10,0
      bind=NONE,l,resizewin,10,0
      bind=NONE,k,resizewin,0,10
      bind=NONE,j,resizewin,0,-10
      bind=NONE,Escape,setkeymode,default

      exec-once=dms run
      exec-once=kitty zsh -c 'fastfetch; exec zsh'
    '';
  };
}
