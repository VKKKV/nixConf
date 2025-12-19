{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # --- Basic Settings (vim.opt) ---
    opts = {
      # Line Numbers
      number = true;
      relativenumber = true;

      # Indentation
      shiftwidth = 4;
      tabstop = 4;
      softtabstop = 4;
      expandtab = true;
      smartindent = true;

      # UI & Behavior
      scrolloff = 4;
      termguicolors = true;
      signcolumn = "yes";
      wrap = true;
      updatetime = 50;
      list = true; # Show invisible characters
      cursorcolumn = true;
      cursorline = true;
      splitbelow = true;
      splitright = true;

      # Search
      incsearch = true;
      hlsearch = true;
      ignorecase = true;
      smartcase = true;

      # Undo
      undofile = true;
      undodir = "/home/user/.vim/undodir";

      foldopen = "mark,percent,quickfix,search,tag,undo";
      guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20";
    };

    globals.mapleader = " ";

    # --- Colorscheme ---
    colorschemes.gruvbox.enable = true;

    # --- Plugins ---
    plugins = {
      web-devicons.enable = true;
      indent-blankline.enable = true;
      comment.enable = true;
      nvim-surround.enable = true;
      nvim-autopairs.enable = true;
      neoscroll.enable = true;
      luasnip.enable = true;
      trouble.enable = true;
      markdown-preview.enable = true;
      vim-visual-multi.enable = true;
      typst-preview-nvim.enable = true;

      tiny-inline-diagnostic-nvim = {
        enable = true;
        settings = {
          options = {
            multilines.enabled = false;
            show_source.enabled = true;
          };
        };
      };

      extraConfigLua = ''
        vim.diagnostic.config({ virtual_text = false })
      '';

      # UI: Statusline
      lualine = {
        enable = true;
        settings = {
          options.theme = "gruvbox";
          tabline.lualine_a = ["buffers"];
        };
      };

      # UI: File Explorer (Oil)
      oil = {
        enable = true;
        settings = {
          delete_to_trash = true;
          view_options.show_hidden = true;
        };
      };

      # UI: Fuzzy Finder
      fzf-lua = {
        enable = true;
        profile = "fzf-native";
      };

      # Syntax Highlighting
      treesitter = {
        enable = true;
        settings = {
          indent.enable = true;
          highlight.enable = true;
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c
          javascript
          lua
          markdown
          python
          rust
          typescript
          vim
          vue
          java
          glsl
        ];
      };

      # LSP Core
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          lua_ls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          pyright.enable = true;
          tinymist.enable = true;
          marksman.enable = true;
          jdtls.enable = true;
        };
        keymaps.lspBuf = {
          K = "hover";
          "<leader>la" = "code_action";
          "<leader>lr" = "rename";
          "<leader>d" = "definition";
        };
      };

      # Formatting
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = ["alejandra"];
            lua = ["stylua"];
            python = ["ruff_format" "black"];
            java = ["google-java-format"];
          };
          format_on_save = ""; # Triggered manually via keymap
        };
      };

      # Autocompletion
      cmp = {
        enable = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          mapping = {
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end)";
            "<S-Tab>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end)";
          };
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "buffer";}
            {name = "path";}
          ];
        };
      };

      # AI Assistance
      copilot-lua = {
        enable = true;
        suggestion = {
          enabled = true;
          autoTrigger = true;
          keymap.accept = "<C-a>";
        };
      };
    };

    # --- Keymaps ---
    keymaps = [
      {
        mode = "n";
        key = "<leader>w";
        action = "<CMD>write<CR>";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<CMD>q<CR>";
      }
      {
        mode = "n";
        key = "<leader>x";
        action = "<CMD>bd<CR>";
      }
      {
        mode = "n";
        key = "<C-L>";
        action = "<CMD>nohlsearch<CR>";
      }

      # Navigation / Explorer
      {
        mode = "n";
        key = "<leader>ff";
        action = "<CMD>FzfLua files<CR>";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<CMD>Oil<CR>";
      }

      # Clipboard
      {
        mode = ["n" "v"];
        key = "<leader>y";
        action = "\"+y";
      }

      # Formatting (Manual trigger)
      {
        mode = ["n" "v"];
        key = "<leader>=";
        action.__raw = ''function() require("conform").format({ async = true, lsp_fallback = true }) end'';
      }
    ];

    # --- Auto Commands ---
    autoCmd = [
      # Trim whitespace on save
      {
        event = "BufWritePre";
        pattern = "*";
        command = "%s/\\s\\+$//e";
      }
      # Typst specific
      {
        event = "FileType";
        pattern = "typst";
        callback.__raw = ''
          function()
            vim.keymap.set("n", "<leader>o", ":TypstPreviewToggle<CR>", { buffer = true, silent = true })
          end
        '';
      }
    ];
  };
}
