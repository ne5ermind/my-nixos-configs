{ ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = ''
        [$directory]($style)
        $character'';

      right_format = "$git_branch$git_metrics$git_status$cmd_duration";

      directory = {
        style = "bold blue";
        #         truncation_length = 3;
        #         truncation_symbol = "…/";
        repo_root_style = "bold bright-blue";
        format = "[$path]($style)[$read_only]($read_only_style) ";
      };

      character = {
        success_symbol = "[❯](bold magenta)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold green)";
      };

      git_branch = {
        symbol = "△ ";
        style = "italic bright-blue";
        format = "[$symbol$branch]($style) ";
      };

      git_metrics = {
        disabled = false;
        added_style = "bold green";
        deleted_style = "bold red";
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
      };

      git_status = {
        style = "bold red";
        format = "([⎪$all_status$ahead_behind⎥]($style) )";
        conflicted = "◪◦";
        ahead = "▴";
        behind = "▿";
        diverged = "◇";
        untracked = "◌◦";
        stashed = "◃◈";
        modified = "●◦";
        staged = "▪️";
        renamed = "◎◦";
        deleted = "✕";
      };

      cmd_duration = {
        min_time = 500;
        format = " [◄ $duration](italic white)";
      };

      add_newline = true;

      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state]($style) ";
        style = "bold blue";
      };
    };
  };
}
