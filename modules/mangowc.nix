{
  wayland.windowManager.mango = {
    enable = true;
    settings = ''
                    #Layout
                    # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
              #     tagrule=id:1,layout_name:tile
              #     tagrule=id:2,layout_name:tile
              #     tagrule=id:3,layout_name:tile
              #     tagrule=id:4,layout_name:tile
              #     tagrule=id:5,layout_name:tile
              #     tagrule=id:6,layout_name:tile
              #     tagrule=id:7,layout_name:tile
              #     tagrule=id:8,layout_name:vertical_scroller
              #     tagrule=id:9,layout_name:scroller
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

                    bind=SUPER,1,view,1
                    bind=SUPER,2,view,<D-t>
                    bind=SUPER,3,view,3
                    bind=SUPER,4,view,4
                    bind=SUPER,5,view,5
                    bind=SUPER,6,view,6
                    bind=SUPER,7,view,7
                    bind=SUPER,8,view,8
                    bind=SUPER,9,view,9
                    bind=SUPER,0,view,10

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

        bind=ALT,R,setkeymode,resize

        keymode=resize
        bind=NONE,Left,resizewin,-10,0
        bind=NONE,Escape,setkeymode,default

        bind=SUPER,f,togglefloating
        bind=SUPER+SHIFT,c,centerwin

        bind=SUPER+SHIFT,s,setlayout,scroller
        bind=SUPER+SHIFT,t,setlayout,tile

        bind=SUPER+SHIFT,r,reload_config

        cursor_size=15
                        # monitors
                    monitorrule=DP-1,0.55,1,scroller,0,1,0,0,2880,1800,120
                    monitorrule=HDMI-A-1,0.50,1,tile,0,1,2880,0,3840,2160,60

                    # theming
                    bordercolor=0x44444444
                    focuscolor=0x66666666
                    borderpx=1
                    blur=1
                    blur_params_radius=3
                    blur_params_passes=2
                    animation_type_open=slide
                    animation_type_close=slide

      exec-once=dms run
      kitty zsh -c 'fastfetch; exec zsh'
    '';
  };
}
