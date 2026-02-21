{
  pkgs,
  inputs,
  ...
}: {
  /**
   * home/common/dev/default.nix
   * Consolidated development tools and environment.
   */

  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  # --- Nixvim Configuration ---
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      tabstop = 4;
      softtabstop = 4;
      expandtab = true;
      smartindent = true;
      timeoutlen = 200;
      ttimeoutlen = 0;
      scrolloff = 4;
      termguicolors = true;
      signcolumn = "yes";
      wrap = true;
      updatetime = 50;
      list = true;
      splitbelow = true;
      splitright = true;
      incsearch = true;
      hlsearch = true;
      ignorecase = true;
      smartcase = true;
      undofile = true;
      undodir.__raw = "vim.fn.stdpath('state') .. '/undo'";
      foldopen = "mark,percent,quickfix,search,tag,undo";
      guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20";
    };

    globals.mapleader = " ";

    colorschemes.kanagawa = {
      enable = true;
      settings = {
        theme = "dragon";
        functionStyle.italic = true;
        variablebuiltinStyle.italic = true;
      };
    };

    plugins = {
      web-devicons.enable = true;
      indent-blankline.enable = true;
      comment.enable = true;
      nvim-surround.enable = true;
      nvim-autopairs.enable = true;
      neoscroll = {
        enable = true;
        settings.duration_multiplier = 0.114514;
      };
      luasnip = {
        enable = true;
        settings.enable_autosnippets = true;
        fromLua = [{paths = ./snippets;}];
      };
      trouble = {
        enable = true;
        settings = {
          focus = true;
          warn_no_results = false;
        };
      };
      markdown-preview.enable = true;
      vim-visual-multi.enable = true;
      typst-preview-nvim.enable = true;
      lazygit.enable = true;
      flash.enable = true;
      ccc.enable = true;
      illuminate.enable = true;
      fidget.enable = true;
      notify = {
        enable = true;
        stages = "static";
        timeout = 2880;
        topDown = false;
        render = "minimal";
      };
      which-key = {
        enable = true;
        settings = {
          preset = "helix";
          spec = [
            {__unkeyed-1 = "<leader>a"; group = "AI"; icon.icon = "󰚩 "; icon.color = "cyan";}
            {__unkeyed-1 = "<leader>f"; group = "find"; icon.icon = " "; icon.color = "green";}
            {__unkeyed-1 = "<leader>g"; group = "git/goto"; icon.icon = "󰊢 "; icon.color = "orange";}
            {__unkeyed-1 = "<leader>l"; group = "lsp/trouble"; icon.icon = "󱖫 "; icon.color = "yellow";}
            {__unkeyed-1 = "<leader>b"; group = "buffer"; icon.icon = "󰓩 "; icon.color = "azure";}
            {__unkeyed-1 = "<leader>q"; group = "quit/session"; icon.icon = "󰗼 "; icon.color = "red";}
            {__unkeyed-1 = "<leader>u"; group = "ui"; icon.icon = "󰙵 "; icon.color = "cyan";}
            {__unkeyed-1 = "g"; group = "goto";}
            {__unkeyed-1 = "["; group = "prev";}
            {__unkeyed-1 = "]"; group = "next";}
          ];
          win.border = "rounded";
        };
      };
      auto-session = {
        enable = true;
        settings = {
          auto_restore_enabled = true;
          auto_save_enabled = true;
          auto_session_suppress_dirs = ["~/" "~/Projects" "~/Downloads" "/"];
        };
      };
      tiny-inline-diagnostic-nvim = {
        enable = true;
        settings = {
          preset = "minimal";
          options = {
            multilines.enabled = false;
            show_source.enabled = true;
          };
        };
      };
      extraPlugins = with pkgs.vimPlugins; [
        multicursor-nvim
        smear-cursor-nvim
        sidekick-nvim
      ];
      extraConfigLua = ''
        vim.diagnostic.config({ virtual_text = false })
        vim.notify = require("notify")
        require("sidekick").setup({ cli = { mux = { backend = "tmux", enabled = true } } })
        require("smear-cursor").setup({
            cursor_color = "#E46876",
            stiffness = 0.6,
            trailing_stiffness = 0.1,
            trailing_exponent = 25,
            gamma = 1,
            damping = 0.4,
            particles_enabled = true,
            particles_per_second = 2000,
            particle_max_lifetime = 1000,
            particle_gravity = 5,
            particle_spread = 1,
            never_draw_over_target = true,
            hide_target_hack = true,
        })
        local mc = require("multicursor-nvim")
        mc.setup()
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { link = "Cursor" })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn" })
        hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
        vim.keymap.set({"n", "x"}, "<C-up>", function() mc.lineAddCursor(-1) end, { desc = "Add cursor up" })
        vim.keymap.set({"n", "x"}, "<C-down>", function() mc.lineAddCursor(1) end, { desc = "Add cursor down" })
        vim.keymap.set({"n", "x"}, "<C-n>", function() mc.matchAddCursor(1) end, { desc = "Add cursor next match" })
        vim.keymap.set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end, { desc = "Skip cursor next match" })
        vim.keymap.set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end, { desc = "Skip cursor previous match" })
        vim.keymap.set({"n", "x"}, "<leader>A", function() mc.matchAllAddCursors() end, { desc = "Add all matches" })
        vim.keymap.set("n", "<esc>", function()
            if not mc.cursorsEnabled() then mc.enableCursors()
            elseif mc.hasCursors() then mc.clearCursors()
            else return "<esc>" end
        end, { expr = true, desc = "Clear/Enable cursors" })
      '';
      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "kanagawa";
            globalstatus = true;
            section_separators = "";
            component_separators = "";
          };
          tabline.lualine_a = ["buffers"];
          sections = {
            lualine_c = [
              "filename"
              "lsp_progress"
              {
                __raw = ''
                  function()
                      local msg = "No Active Lsp"
                      local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                      if next(clients) == nil then return msg end
                      local name = {}
                      for _, client in ipairs(clients) do table.insert(name, client.name) end
                      return table.concat(name, ", ")
                  end
                '';
              }
            ];
            lualine_z = ["location"];
          };
        };
      };
      oil = {
        enable = true;
        settings = {
          delete_to_trash = true;
          view_options.show_hidden = true;
          skip_confirm_for_simple_edits = true;
          float = {padding = 2; max_width = 0.6; max_height = 0.8; border = "rounded";};
        };
      };
      fzf-lua = {
        enable = true;
        settings = {
          winopts = {
            height = 0.95; width = 0.66;
            preview = {layout = "vertical"; vertical = "up:40%"; scrollbar = false;};
          };
          files.formatter = "path.filename_first";
          grep.formatter = "path.filename_first";
        };
      };
      treesitter = {
        enable = true;
        settings = {
          indent.enable = true;
          highlight = {
            enable = true;
            disable.__raw = ''
              function(lang, buf)
                  if lang == "html" then return true end
                  local max_filesize = 114 * 1024
                  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                  if ok and stats and stats.size > max_filesize then return true end
              end
            '';
          };
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash c javascript lua markdown python rust typescript vim vue java glsl nix json html css yaml kotlin go
        ];
      };
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          lua_ls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            settings.rust-analyzer.inlayHints = {
              bindingModeHints.enable = false;
              chainingHints.enable = true;
              closingBraceHints = {enable = true; minLines = 25;};
              closureReturnTypeHints.enable = "always";
              lifetimeElisionHints = {enable = "always"; useParameterNames = true;};
              maxLength = 25;
              parameterHints.enable = true;
              reborrowHints.enable = "always";
              renderColons = true;
              typeHints = {enable = true; hideClosureInitialization = false; hideNamedConstructor = false;};
            };
          };
          pyright.enable = true;
          tinymist.enable = true;
          marksman.enable = true;
          ts_ls.enable = true;
          bashls.enable = true;
          gopls.enable = true;
          jsonls.enable = true;
          html.enable = true;
          cssls.enable = true;
          yamlls.enable = true;
          kotlin_language_server = {
            enable = true;
            settings.kotlin.compiler.jvm.target = "17";
          };
          glsl_analyzer.enable = true;
        };
        keymaps.lspBuf = {
          K = "hover";
          "<leader>la" = "code_action";
          "<leader>lr" = "rename";
          "<leader>d" = "definition";
        };
      };
      jdtls.enable = true;
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = ["alejandra"];
            lua = ["stylua"];
            python = ["ruff_format" "black"];
            java = ["google-java-format"];
          };
          format_on_save = "";
        };
      };
      blink-cmp = {
        enable = true;
        settings = {
          keymap.preset = "default";
          completion = {
            list.selection = {preselect = true; auto_insert = false;};
            menu.auto_show = true;
            documentation = {auto_show = true; auto_show_delay_ms = 50;};
          };
          signature.enabled = true;
          appearance.nerd_font_variant = "mono";
          sources.default = ["lsp" "path" "snippets" "buffer" "copilot"];
          sources.providers.copilot = {
            name = "copilot";
            module = "blink-cmp-copilot";
            score_offset = 100;
            async = true;
          };
        };
      };
      copilot-lua = {
        enable = true;
        suggestion.enabled = false;
        panel.enabled = false;
      };
      copilot-cmp.enable = true;
    };

    keymaps = [
      {mode = "n"; key = "<leader>w"; action = "<CMD>write<CR>"; options.desc = "Save file";}
      {mode = "n"; key = "<leader>q"; action = "<CMD>q<CR>"; options.desc = "Quit";}
      {mode = "n"; key = "<leader>n"; action = "<CMD>bnext<CR>"; options.desc = "Next buffer";}
      {mode = "n"; key = "<leader>p"; action = "<CMD>bprevious<CR>"; options.desc = "Previous buffer";}
      {mode = "n"; key = "<leader>x"; action = "<CMD>bdelete<CR>"; options.desc = "Close buffer";}
      {mode = "n"; key = "<leader><Tab>"; action = "<C-^>"; options.desc = "Switch to last buffer";}
      {mode = "n"; key = "<C-L>"; action = "<CMD>nohlsearch<CR>";}
      {mode = "n"; key = "<leader>?"; action.__raw = ''function() require("which-key").show({ global = false }) end''; options.desc = "Buffer Local Keymaps (which-key)";}
      {mode = "n"; key = "<leader>ff"; action = "<CMD>FzfLua files<CR>"; options.desc = "Fzf Files";}
      {mode = "n"; key = "<leader>fr"; action = "<CMD>FzfLua live_grep<CR>"; options.desc = "Fzf Live Grep";}
      {mode = "n"; key = "<leader>fb"; action = "<CMD>FzfLua buffers<CR>"; options.desc = "Fzf Buffers";}
      {mode = "n"; key = "<leader>fk"; action = "<CMD>FzfLua keymaps<CR>"; options.desc = "Fzf Keymaps";}
      {mode = "n"; key = "<leader>e"; action = "<CMD>Oil --float<CR>"; options.desc = "Oil File Explorer (Float)";}
      {mode = ["n" "x" "o"]; key = "s"; action.__raw = ''function() require("flash").jump() end''; options.desc = "Flash";}
      {mode = ["n" "v"]; key = "<leader>y"; action = "\"+y"; options.desc = "Yank to system clipboard";}
      {mode = "n"; key = "<leader>/"; action = "gcc"; options = {remap = true; desc = "Toggle Line Comment";};}
      {mode = "v"; key = "<leader>/"; action = "gc`]"; options = {remap = true; desc = "Toggle Comment Selection";};}
      {mode = ["n" "v"]; key = "<leader>="; action.__raw = ''function() require("conform").format({ async = true, lsp_fallback = true }) end''; options.desc = "Format code";}
      {mode = "n"; key = "<leader>lg"; action = "<CMD>LazyGit<CR>"; options.desc = "LazyGit";}
      {mode = "n"; key = "<leader>ld"; action = "<CMD>Trouble diagnostics toggle<CR>"; options.desc = "Diagnostics (Trouble)";}
      {mode = "n"; key = "<leader>ls"; action = "<CMD>Trouble symbols toggle focus=false<CR>"; options.desc = "Symbols (Trouble)";}
      {mode = "n"; key = "<leader>lq"; action = "<CMD>Trouble qflist toggle<CR>"; options.desc = "Quickfix List (Trouble)";}
      {mode = ["n" "t" "x"]; key = "<leader>."; action.__raw = ''function() require("sidekick.cli").toggle() end''; options.desc = "Sidekick Toggle";}
      {mode = "n"; key = "<leader>aa"; action.__raw = ''function() require("sidekick.cli").toggle() end''; options.desc = "Sidekick Toggle CLI";}
      {mode = "x"; key = "<leader>av"; action.__raw = ''function() require("sidekick.cli").send({ msg = "{selection}" }) end''; options.desc = "Send Visual Selection";}
      {mode = "n"; key = "<leader>fs"; action = "<CMD>AutoSession search<CR>"; options.desc = "Session Search";}
      {mode = "n"; key = "<leader>qr"; action = "<CMD>AutoSession restore<CR>"; options.desc = "Session Restore";}
    ];

    autoCmd = [
      {event = "TextYankPost"; desc = "Highlight when yanking text"; callback.__raw = "function() vim.highlight.on_yank() end";}
      {event = "BufReadPost"; callback.__raw = ''function() local mark = vim.api.nvim_buf_get_mark(0, '"'); local lcount = vim.api.nvim_buf_line_count(0); if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end end'';}
      {event = ["FocusGained" "BufEnter" "CursorHold" "CursorHoldI"]; callback.__raw = ''function() if vim.fn.getcmdwintype() == "" then vim.cmd("checktime") end end'';}
      {event = "FileType"; pattern = ["typst" "markdown"]; callback.__raw = ''function(args) local cmd = (args.match == "typst") and "<cmd>TypstPreviewToggle<CR>" or "<cmd>MarkdownPreviewToggle<CR>"; vim.keymap.set("n", "<leader>o", cmd, { noremap = true, silent = true, buffer = args.buf, desc = "Toggle Preview" }) end'';}
      {event = "LspAttach"; callback.__raw = ''function(event) local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, silent = true, desc = desc }) end; map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic"); map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev Diagnostic"); map("n", "K", vim.lsp.buf.hover, "Hover Documentation"); map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol"); map("n", "<leader>la", "<cmd>FzfLua lsp_code_actions<cr>", "Code Actions"); map("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", "Go to Definition"); map("n", "gD", "<cmd>FzfLua lsp_declarations<cr>", "Go to Declaration"); map("n", "gi", "<cmd>FzfLua lsp_implementations<cr>", "Go to Implementation"); map("n", "gr", "<cmd>FzfLua lsp_references<cr>", "Go to References"); map("n", "gs", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", "Go to Symbols"); map("n", "<leader>li", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, "Inlay Hints") end'';}
      {event = ["InsertLeave" "FocusLost"]; callback.__raw = ''function() if _G.save_timer then vim.uv.timer_stop(_G.save_timer) end; _G.save_timer = vim.uv.new_timer(); vim.uv.timer_start(_G.save_timer, 115, 0, vim.schedule_wrap(function() if vim.bo.modified and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then vim.cmd("silent! write") end; _G.save_timer = nil end)) end'';}
      {event = "FileType"; pattern = "java"; callback.__raw = ''
          function()
            local root_dir = vim.fs.root(0, { { "wtf", ".git/" }, "mvnw", "gradlew" }) or vim.fn.getcwd()
            local jdtls = require("jdtls")
            local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
            local workspace_dir = vim.fn.expand("~/.cache/jdtls/") .. project_name
            local lombok_path = "/usr/share/java/lombok/lombok.jar"
            if vim.fn.isdirectory(workspace_dir) == 0 then vim.fn.mkdir(workspace_dir, "p") end
            local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = true, silent = true, desc = desc }) end
            map("n", "<A-o>", jdtls.organize_imports, "Organize Imports")
            vim.env.JAVA_HOME = "/usr/lib/jvm/java-21-graalvm-ee"
            vim.env.PATH = vim.env.JAVA_HOME .. "/bin:" .. vim.env.PATH
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            jdtls.start_or_attach({
                name = "jdtls", capabilities = capabilities,
                cmd = {"jdtls", "-data", workspace_dir, "--jvm-arg=-javaagent:" .. lombok_path, "--jvm-arg=-XX:+UnlockExperimentalVMOptions", "--jvm-arg=-XX:+UseJVMCICompiler", "--jvm-arg=-XX:+UseZGC", "--jvm-arg=-XX:+ZGenerational", "--jvm-arg=-Xmx4G", "--jvm-arg=-XX:ZUncommitDelay=60", "--jvm-arg=-XX:ZAllocationSpikeTolerance=5", "--jvm-arg=-Djava.awt.headless=true", "--jvm-arg=-Xrs"},
                root_dir = root_dir,
                settings = { java = { inlayHints = { parameterNames = { enabled = "all" } }, signatureHelp = { enabled = true }, contentProvider = { preferred = "fernflower" }, sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999, }, }, codeGeneration = { toString = { template = "$\{object.className}{$\{member.name()}=$\{member.value}, $\{otherMembers}}", }, hashCodeEquals = { useJava7Objects = true, }, useBlocks = true, }, project = { referencedLibraries = { "**/lib/*.jar", }, }, configuration = { runtimes = { { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk/", default = true }, { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk/" }, }, }, }, },
            })
            local jdtls_ui = require("jdtls.ui")
            local fzf = require("fzf-lua")
            function jdtls_ui.pick_many(items, prompt, label_fn)
                local co = coroutine.running()
                if not co then print("❌ Error: pick_many must be run in a coroutine"); return {} end
                local choices = {}; for i, item in ipairs(items) do local text = label_fn(item); table.insert(choices, string.format("%d|%s", i, text)) end
                local is_picked = false
                fzf.fzf_exec(choices, {
                    prompt = prompt .. "> ",
                    fzf_opts = { ["--multi"] = true, ["--delimiter"] = "|", ["--with-nth"] = "2..", ["--bind"] = "alt-a:select-all", },
                    actions = { ["default"] = function(selected, _) is_picked = true; vim.schedule(function() local result = {}; if selected then for _, text in ipairs(selected) do local index_str = text:match("^(%d+)|"); local index = tonumber(index_str); if index and items[index] then table.insert(result, items[index]) end end end; if coroutine.status(co) == "suspended" then coroutine.resume(co, result) end end) end, },
                    winopts = { height = 0.6, width = 0.6, on_close = function() vim.defer_fn(function() if not is_picked and coroutine.status(co) == "suspended" then coroutine.resume(co, {}) end end, 20) end, },
                }); return coroutine.yield()
            end
          end
        '';}
    ];
  };

  # --- Git Configuration ---
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "vkkkv";
        email = "vkkkv@example.com";
      };
      init.defaultBranch = "main";
      diff.colorMoved = "default";
      color.ui = true;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui.border = "single";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
    hosts."github.com" = {
      users."vkkkv" = null;
      user = "vkkkv";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      side-by-side = false;
      diff-so-fancy = true;
      navigate = true;
    };
  };

  xdg.configFile."git/.gitignore".text = ''
    .vscode
    .idea
  '';

  # --- SSH Configuration ---
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };
  services.ssh-agent.enable = true;

  # --- Vim Configuration ---
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-indent-guides
      vim-visual-multi
      vim-instant-markdown
      fzf-vim
      fzfWrapper
      typst-vim
      nerdtree
      tcomment_vim
      vim-surround
      vim-snippets
      gruvbox
      vim-airline
      vim-airline-themes
    ];
    extraConfig = ''
      syntax enable
      set autoindent
      set autoread
      set autowrite
      set breakindent
      set cmdheight=2
      set cursorcolumn
      set cursorline
      set encoding=utf-8
      set expandtab
      set fileformat=unix
      set foldlevel=999
      set foldlevelstart=999
      set foldmethod=syntax
      set hidden
      set hlsearch
      set ignorecase
      set incsearch
      set laststatus=2
      set list
      set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:%
      set nobackup
      set noswapfile
      set nowritebackup
      set number
      set relativenumber
      set scrolloff=4
      set shiftwidth=4
      set shortmess+=c
      set showbreak=↪
      set signcolumn=yes
      set smartindent
      set smarttab
      set softtabstop=4
      set splitbelow
      set splitright
      set tabstop=4
      set termguicolors
      set timeoutlen=400
      set title
      set updatetime=500
      set wildmenu
      set wrap

      let mapleader=" "
      nnoremap <silent> <Leader>w :w<CR>
      nnoremap <silent> <Leader>q :q<CR>
      nnoremap <silent> <Leader>n :bn<CR>
      nnoremap <silent> <Leader>p :bp<CR>
      nnoremap <silent> <Leader>x :bd<CR>
      nnoremap <silent> <Leader><Tab> <C-^>
      nnoremap <silent> <Leader>v :vsplit<CR>

      " Tab management
      nnoremap <silent> <Leader>tn :tabn<CR>
      nnoremap <silent> <Leader>tp :tabp<CR>

      " Window management
      nnoremap <silent> <C-Up>    :resize -2<CR>
      nnoremap <silent> <C-Down>  :resize +2<CR>
      nnoremap <silent> <C-Left>  :vertical resize -2<CR>
      nnoremap <silent> <C-Right> :vertical resize +2<CR>
      nnoremap <silent> <Leader>h :wincmd h<CR>
      nnoremap <silent> <Leader>j :wincmd j<CR>
      nnoremap <silent> <Leader>k :wincmd k<CR>
      nnoremap <silent> <Leader>l :wincmd l<CR>

      " Clipboard & Search
      xnoremap <silent> <leader>y :w !wl-copy<CR><CR>
      nnoremap <C-L> :nohlsearch<CR><C-L>

      " LazyGit
      nnoremap <silent> <Leader>lg :!lazygit<CR>

      " Commenting (via tcomment_vim)
      nmap <Leader>/ gcc
      vmap <Leader>/ gc

      filetype plugin indent on

      autocmd Filetype markdown setlocal wrap linebreak
      autocmd Filetype markdown setlocal colorcolumn=80
      autocmd Filetype markdown setlocal textwidth=80
      autocmd Filetype * :setlocal fo-=o fo-=r
      autocmd BufWritePre * :%s/\s\+$//e

      " Plugin settings
      let g:indent_guides_enable_on_vim_startup = 1

      let g:instant_markdown_autostart = 0
      let g:instant_markdown_autoscroll = 1
      let g:instant_markdown_port = 13487
      let g:instant_markdown_theme = 'dark'
      nnoremap <Leader>i :InstantMarkdownPreview<CR>

      nnoremap <Leader>ff :Files!<CR>
      nnoremap <Leader>fr :Rg!<CR>
      nnoremap <Leader>fh :History!<CR>
      nnoremap <Leader>fb :Buffers!<CR>
      nnoremap <Leader>ft :Lines!<CR>

      let g:typst_pdf_viewer = 'zathura'

      nnoremap <Leader>e :NERDTreeToggle<CR>
      let NERDTreeShowHidden=1
      let NERDTreeQuitOnOpen=1
      let NERDTreeAutoDeleteBuffer=1
      let NERDTreeConfirmDelete='yes'
      let NERDTreeConfirmRename='yes'

      let g:airline_theme='gruvbox'
      let g:airline_powerline_fonts = 1
      let g:airline_section_z = "%3p%% %l:%c"
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#formatter = 'unique_tail'
      if !exists('g:airline_symbols')
            let g:airline_symbols = {}
      endif
      let g:airline_symbols.colnr = ' ℅:'

      autocmd vimenter * ++nested colorscheme gruvbox
      set background=dark
    '';
  };
}
