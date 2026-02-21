{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    historySubstringSearch.enable = true;
    shellAliases = {
      ls = "eza --icons --group-directories-first";
      ll = "eza -lh --icons --grid";
      cat = "bat";
      btw = "echo 'i use nixos btw'";
      update = ''
        (
          cd /etc/nixos
          sudo systemctl stop zapret-discord-youtube.service
          sudo git add *
          sudo git commit -m "automatic commit on config update"
          sudo nixos-rebuild switch --flake .#nevernix
        )
      '';
      cfg = "cd /etc/nixos";
      matrix = "neo --colormode=0 -a -f 120 -S 7 -D ";
      ff = "fastfetch";
      check = "ollama run qwen2.5:3b";
    };
    loginExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec hyprland
      fi
      eval "$(starship init zsh)"
    '';
  };
}
