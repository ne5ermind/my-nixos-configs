{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    plugins = {
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        nixvimInjections = true;
      };

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          pyright = {
            enable = true;
          };
        };
        keymaps.lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "K" = "hover";
          "gi" = "implementation";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "vim-dadbod-completion"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<c-e>" = "cmp.mapping.close()";
            "<tab>" = "cmp.mapping.confirm({ select = true })";
            "<down>" = "cmp.mapping.select_next_item()";
            "<up>" = "cmp.mapping.select_prev_item()";
            "<c-d>" = "cmp.mapping.scroll_docs(-4)";
            "<c-f>" = "cmp.mapping.scroll_docs(4)";
          };
          window.documentation = {
            __raw = "cmp.config.disable";
          };
          formatting.format = ''
            function(entry, vim_item)
                if vim.tbl_contains({ 'Snippet' }, vim.lsp.protocol.CompletionItemKind[entry:get_kind()]) then
                    return nil
                end
                return vim_item
            end
          '';
          performance.max_view_entries = 8;
        };
      };

      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
          map_bs = true;
          map_cr = true;
          disable_filetype = [ "TelescopePrompt" ];
        };
        extraConfigLua = ''
          local npairs = require("nvim-autopairs")
          local Rule = require('nvim-autopairs.rule')
          local cond = require('nvim-autopairs.conds')
          npairs.remove_rule('{')
          npairs.add_rules({
              Rule("{", "};", "nix")
                  :append_pair("}")
                  :with_pair(cond.not_after_text("}"))
          })
          npairs.add_rules({
              Rule("{", "}", "-nix")
          })
        '';
      };

      vim-dadbod = {
        enable = true;
      };

      vim-dadbod-ui = {
        enable = true;
      };

      vim-dadbod-completion = {
        enable = true;
      };

      mini = {
        enable = true;
        modules = {
          indentscope = { };
        };
      };

      neo-tree = {
        enable = true;
        enable_diagnostics = true;
        settings = {
          enableGitStatus = true;
        };
      };

      undotree = {
        enable = true;
        settings = {
          WindowLayout = 3;
        };
      };

      barbar = {
        enable = true;
        settings = {
          animation = true;
          clickable = true;
          icons = {
            filetype.enabled = true;
            button = "x";
          };
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            python = [ "black" ];
            lua = [ "stylua" ];
          };
        };
      };

      guess-indent.enable = true;

      web-devicons.enable = true;

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          ui-select = {
            enable = true;
            settings = {
              specific_opts.ui-select.__raw = ''
                require("telescope.themes").get_dropdown()
              '';
            };
          };
        };
        keymaps = {
          "<leader>sh" = {
            action = "help_tags";
            options.desc = "[S]earch [H]elp";
          };
          "<leader>sk" = {
            action = "keymaps";
            options.desc = "[S]earch [K]eymaps";
          };
          "<leader>sf" = {
            action = "find_files";
            options.desc = "[S]earch [F]iles";
          };
          "<leader>ss" = {
            action = "builtin";
            options.desc = "[S]earch [S]elect Telescope";
          };
          "<leader>sw" = {
            action = "grep_string";
            options.desc = "[S]earch current [W]ord";
          };
          "<leader>sg" = {
            action = "live_grep";
            options.desc = "[S]earch by [G]rep";
          };
          "<leader>sd" = {
            action = "diagnostics";
            options.desc = "[S]earch [D]iagnostics";
          };
          "<leader>sr" = {
            action = "resume";
            options.desc = "[S]earch [R]esume";
          };
          "<leader>s." = {
            action = "oldfiles";
            options.desc = "[S]earch Recent Files";
          };
          "<leader><leader>" = {
            action = "buffers";
            options.desc = "[ ] Find existing buffers";
          };
        };
      };

      lint = {
        enable = true;
        lintersByFt = {
          nix = [ "statix" ];
          python = [ "pylint" ];
          lua = [ "selene" ];
        };
        autoCmd = {
          callback.__raw = ''
            function()
                require('lint').try_lint()
            end
          '';
          event = [
            "BufEnter"
            "BufWritePost"
            "InsertLeave"
          ];
        };
      };

      indent-blankline = {
        enable = true;
        settings = {
          indent.char = "»";
          whitespace.remove_blankline_trail = true;
          scope = {
            enabled = true;
            show_start = true;
          };
        };
      };

      molten = {
        enable = true;
        settings = {
          image_provider = "image.nvim";
          output_win_max_height = 20;
          auto_save_to_persistent_msgs = true;
          auto_open_output = false;
          virt_text_output = true;
          wrap_output = true;
          virt_lines_off_by_1 = true;
        };
      };

      notebook-navigator = {
        enable = true;
        settings = {
          activate_highlight_on_cursor = true;
          repl_handler = "molten";
        };
      };

      quarto = {
        enable = true;
        settings = {
          lspFeatures = {
            enabled = true;
            languages = [ "python" ];
            chunks = "all";
          };
        };
      };

      image = {
        enable = true;
        backend = "kitty";
        maxWidth = 80;
        maxHeight = 40;
        settings = {
          editor_only_render_when_focused = false;
          window_overlap_clear_enabled = true;
          window_overlap_clear_ft_ignore = [
            "cmp_menu"
            "blink.cmp"
            "floating"
          ];
        };
        integrations = {
          syslang = { };
        };
      };

      otter = {
        enable = true;
        settings = {
          handle_leading_whitespace = true;
        };
      };

      illuminate = {
        enable = true;
        filetypesDenyList = [
          "neo-tree"
          "TelescopePrompt"
        ];
        settings = {
          underCursor = true;
          delay = 30;
        };
      };

      flash.enable = true;

      jupytext = {
        enable = true;
        settings = {
          custom_extension = ".py";
          style = "percent";
          force_ft = "python";
        };
      };

      which-key = {
        settings = {
          icons = {
            breadcrumb = "»";
            separator = "➜";
            group = "+";
          };
          win = {
            border = "rounded";
            no_overlap = true;
            padding = [
              1
              2
            ];
          };
          layout = {
            align = "center";
          };
          spec = [
            {
              __unkeyed-1 = "<leader>s";
              group = "[S]earch";
              icon = "   ";
            }
            {
              __unkeyed-1 = "<leader>h";
              group = "[H]arpoon";
              icon = "   ";
            }
            {
              __unkeyed-1 = "<leader>m";
              group = "[M]olten";
              icon = "   ";
            }
            {
              __unkeyed-1 = "<leader>f";
              group = "[F]ormat";
              icon = "   ";
            }
          ];
        };
      };

      alpha = {
        enable = false;
        theme = "dashboard";
        sections = {
          header.val = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            "░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓██████████████▓▒░"
            "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░"
            "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░       ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░"
            "░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░  ░▒▓█▓▒▒▓█▓▒░░▒▓██████▓▒░ ░▒▓███████▓▒░ ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░"
            "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░"
            "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░"
            "░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░  ░▒▓██▓▒░  ░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓██▓▒░  ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░"
          ];
          buttons.val = [
            {
              __raw = "require('alpha.themes.dashboard').button('n', '  New file', ':ene <BAR> startinsert<CR>')";
            }
            {
              __raw = "require('alpha.themes.dashboard').button('f', '  Find file', ':cd $HOME/ | Telescope find_files<CR>')";
            }
            {
              __raw = "require('alpha.themes.dashboard').button('r', '    Recent', ':Telescope oldfiles<CR>')";
            }
            {
              __raw = "require('alpha.themes.dashboard').button('w', '  Find Word', ':Telescope live_grep<CR>')";
            }
            {
              __raw = "require('alpha.themes.dashboard').button('s', '  Settings', ':e ~/nixos/home.nix<CR>')";
            }
            { __raw = "require('alpha.themes.dashboard').button('q', '    Quit', '<cmd>q<CR>')"; }
          ];
          footer.val = [
            ""
            ""
            "nevervim for NixOS"
          ];
        };
      };
    };

    keymaps = [
      # Autoformatiing
      {
        mode = "";
        key = "<leader>f";
        action.__raw = ''
                          	function()
          				        require("conform").format({ async = true, lsp_format = "fallback" })
          			        end
        '';
        options = {
          desc = "Format buffer";
        };
      }

      # Diagnosticd
      {
        mode = "n";
        key = "<leader>q";
        action.__raw = "vim.diagnostic.setloclist";
        options.desc = "Open diagnostic [Q]uickfix list";
      }
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options.desc = "Exit terminal mode";
      }

      # Navigating windows
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options.desc = "Move focus to the left window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options.desc = "Move focus to the right window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options.desc = "Move focus to the lower window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options.desc = "Move focus to the upper window";
      }

      # Manipulating lines
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Moves lines down in visual selection";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Moves lines up in visual selection";
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.silent = true;
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.silent = true;
      }

      # Search results navigating
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
      }
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>noh<CR>";
        options.silent = true;
      }

      # Buffer control
      {
        mode = "n";
        key = "<A-,>";
        action = "<Cmd>BufferPrevious<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<A-.>";
        action = "<Cmd>BufferNext<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<A-<>";
        action = "<Cmd>BufferMovePrevious<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<A->>";
        action = "<Cmd>BufferMoveNext<CR>";
        options.silent = true;
      }

      # Buffer navigating
      {
        mode = "n";
        key = "<A-1>";
        action = "<Cmd>BufferGoto 1<CR>";
      }
      {
        mode = "n";
        key = "<A-2>";
        action = "<Cmd>BufferGoto 2<CR>";
      }
      {
        mode = "n";
        key = "<A-3>";
        action = "<Cmd>BufferGoto 3<CR>";
      }
      {
        mode = "n";
        key = "<A-4>";
        action = "<Cmd>BufferGoto 4<CR>";
      }
      {
        mode = "n";
        key = "<A-5>";
        action = "<Cmd>BufferGoto 5<CR>";
      }
      {
        mode = "n";
        key = "<A-6>";
        action = "<Cmd>BufferGoto 6<CR>";
      }
      {
        mode = "n";
        key = "<A-7>";
        action = "<Cmd>BufferGoto 7<CR>";
      }
      {
        mode = "n";
        key = "<A-8>";
        action = "<Cmd>BufferGoto 8<CR>";
      }
      {
        mode = "n";
        key = "<A-9>";
        action = "<Cmd>BufferGoto 9<CR>";
      }
      {
        mode = "n";
        key = "<A-0>";
        action = "<Cmd>BufferLast<CR>";
      }

      # Buffer control
      {
        mode = "n";
        key = "<A-p>";
        action = "<Cmd>BufferPin<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<A-c>";
        action = "<Cmd>BufferClose<CR>";
        options.silent = true;
      }

      # Molten
      {
        mode = "n";
        key = "<localleader>os";
        action = ":noautocmd MoltenEnterOutput<CR>";
        options = {
          desc = "open output window";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<localleader>rr";
        action = ":MoltenReevaluateCell<CR>";
        options = {
          desc = "re-eval cell";
          silent = true;
        };
      }
      {
        mode = "v";
        key = "<localleader>r";
        action = ":<C-u>MoltenEvaluateVisual<CR>gv";
        options = {
          desc = "execute visual selection";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<localleader>oh";
        action = ":MoltenHideOutput<CR>";
        options = {
          desc = "close output window";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<localleader>md";
        action = ":MoltenDelete<CR>";
        options = {
          desc = "delete Molten cell";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>X";
        action = "<cmd>lua require('notebook-navigator').run_cell()<cr>";
        options.desc = "Run cell";
      }
      {
        mode = "n";
        key = "<leader>x";
        action = "<cmd>lua require('notebook-navigator').run_and_move()<cr>";
        options.desc = "Run and move";
      }
      {
        mode = "n";
        key = "[c";
        action = '':lua require('notebook-navigator').move_cell("u")<CR>'';
        options.desc = "Prev cell";
      }
      {
        mode = "n";
        key = "]c";
        action = '':lua require('notebook-navigator').move_cell("d")<CR>'';
        options.desc = "Next cell";
      }

      # Flash code navigation
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action.__raw = ''function() require("flash").jump() end'';
        options.desc = "Flash Jump";
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "S";
        action.__raw = ''function() require("flash").treesitter() end'';
        options.desc = "Flash Treesitter selecting code blocks";
      }

      # Molten
      {
        mode = "n";
        key = "<leader>ms";
        action = ":MoltenSave<CR>";
        options.desc = "Save Molten output to file";
      }
      {
        mode = "n";
        key = "<leader>ml";
        action = ":MoltenLoad<CR>";
        options.desc = "Load Molten output from file";
      }
      {
        mode = "n";
        key = "<leader>mi";
        action = ":MoltenInit<CR>";
        options.desc = "Initialize Molten";
      }
      {
        mode = "n";
        key = "<leader>mz";
        action = ":MoltenInterrup<CR>";
        options.desc = "Interrupt kernal";
      }
      {
        mode = "n";
        key = "<leader>mra";
        action = ":MoltenReevaluateAll<CR>";
        options.desc = "Reevaluate all cells";
      }

      # DB control
      {
        mode = "n";
        key = "<leader>db";
        action = ":DBUIToggle<CR>";
        options.desc = "Toggle dadbod UI";
      }
      {
        mode = "n";
        key = "<leader>S";
        action = "<Plug>(DBUI_ExecuteQuery)";
        options.desc = "Execute cuurent query";
      }
      {
        mode = "v";
        key = "<leader>S";
        action = ":DB<CR>";
        options.desc = "execute selected SQL code";
      }
      {
        mode = "n";
        key = "<leader>dc";
        action = ":pc<CR>";
        options.desc = "Close results preview window";
      }

      # Other things
      {
        mode = "n";
        key = "<Bslash>";
        action = ":Neotree toggle reveal<CR>";
        options = {
          silent = true;
          desc = "Toggle NeoTree";
        };
      }
      {
        mode = "n";
        key = "<leader>u";
        action = "<cmd>UndotreeToggle<cr>";
        options.desc = "Toggle undo tree";
      }

    ];

    autoCmd = [
      {
        event = [ "TextYankPost" ];
        desc = "Highlight when yanking (copying) text";
        callback.__raw = ''
          function()
              vim.hl.on_yank()
          end
        '';
      }
      {
        event = [ "FileType" ];
        pattern = [ "python" ];
        callback.__raw = ''
          function()
              vim.treesitter.start()
          end
        '';
      }
      {
        event = [ "User" ];
        pattern = [ "AlphaReady" ];
        callback.__raw = ''
          function()
              vim.opt.showtabline = 0
              vim.opt.laststatus = 0
              vim.opt.cmdheight = 0
          end
        '';
      }
      {
        event = [ "BufUnload" ];
        pattern = [ "<buffer>" ];
        callback.__raw = ''
          function()
              vim.opt.showtabline = 2
              vim.opt.laststatus = 2
              vim.opt.cmdheight = 1
          end
        '';
      }
    ];

    colorschemes.cyberdream = {
      enable = true;
      autoLoad = true;
      settings = {
        variant = "light";
        borderless_telescope = true;
        hide_fillchars = true;
        italic_comments = true;
        terminal_colors = true;
        theme = {
          highlights = {
            Comment = {
              bg = "NONE";
              fg = "#696969";
              italic = true;
            };
          };
        };
        transparent = true;
      };
    };

    highlight = {
      AlphaButton = {
        fg = "#ffffff";
      };
      AlphaHeader = {
        fg = "#ffffff";
      };
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      # UI settings
      number = true;
      relativenumber = true;
      termguicolors = true;
      cursorline = true;
      showmode = false;
      signcolumn = "yes";

      # Tab settings
      shiftwidth = 4;
      tabstop = 4;
      softtabstop = 4;
      expandtab = true;
      breakindent = true;

      # Search
      ignorecase = true;
      smartcase = true;

      # Buffer files
      backup = false;
      swapfile = false;
      undofile = true;
      confirm = true;
      clipboard = "unnamedplus";

      # Scroll settings
      scrolloff = 10;

      # Allow additional config from local files
      exrc = true;
    };

    extraPackages = with pkgs; [
      gcc
      imagemagick
      tree-sitter
      nodejs
      ripgrep
      fd
      statix
      nixfmt-rfc-style
      nodePackages.eslint_d
      selene
    ];

    filetype.extension.ipynb = "python";
  };
}
