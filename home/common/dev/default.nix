{pkgs, ...}: {
  /**
   * home/common/dev/default.nix
   * Consolidated development tools and environment.
   */

  imports = [
    ./nixvim
  ];

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
