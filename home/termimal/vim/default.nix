{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-indent-guides
      vim-visual-multi
      fzf-vim
      fzfWrapper
      typst-vim
      nerdtree
      tcomment_vim
      vim-surround
      vim-snippets
      coc-nvim
      copilot-vim
      gruvbox
      vim-airline
      vim-airline-themes
    ];
    settings = {
      background = "dark";
      expandtab = true;
      hidden = true;
      ignorecase = true;
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      tabstop = 4;
    };
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
      set fileformat=unix
      set foldlevel=999
      set foldlevelstart=999
      set foldmethod=syntax
      set hlsearch
      set incsearch
      set laststatus=2
      set list
      set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:%
      set nobackup
      set noswapfile
      set nowritebackup
      set scrolloff=4
      set shortmess+=c
      set showbreak=↪
      set signcolumn=yes
      set smartindent
      set smarttab
      set softtabstop=4
      set splitbelow
      set splitright
      set termguicolors
      set timeoutlen=400
      set title
      set updatetime=500
      set wildmenu
      set wrap

      let mapleader=" "
      nnoremap <silent> <Leader>w :w<CR>
      nnoremap <silent> <Leader>tn :tabn<CR>
      nnoremap <silent> <Leader>tp :tabp<CR>
      nnoremap <silent> <Leader>p :bp<CR>
      nnoremap <silent> <Leader>n :bn<CR>
      nnoremap <silent> <Leader>x :bd<CR>
      nnoremap <silent> <Leader>q :q<CR>
      nnoremap <silent> <Leader>v :vsplit<CR>
      nnoremap <silent> <C-Up>    :resize -2<CR>
      nnoremap <silent> <C-Down>  :resize +2<CR>
      nnoremap <silent> <C-Left>  :vertical resize -2<CR>
      nnoremap <silent> <C-Right> :vertical resize +2<CR>
      nnoremap <silent> <Leader>h :wincmd h<CR>
      nnoremap <silent> <Leader>j :wincmd j<CR>
      nnoremap <silent> <Leader>k :wincmd k<CR>
      nnoremap <silent> <Leader>l :wincmd l<CR>
      xnoremap <silent> cp :w !wl-copy<CR><CR>
      nnoremap <C-L> :nohlsearch<CR><C-L>

      filetype plugin indent on

      autocmd Filetype markdown setlocal wrap linebreak
      autocmd Filetype markdown setlocal colorcolumn=80
      autocmd Filetype markdown setlocal textwidth=80
      autocmd Filetype * :setlocal fo-=o fo-=r
      autocmd BufWritePre * :%s/\s\+$//e

      " Plug config
      nnoremap <Leader>ff :Files!<CR>
      nnoremap <Leader>fr :Rg!<CR>
      nnoremap <Leader>fh :History!<CR>
      nnoremap <Leader>fb :Buffers!<CR>
      nnoremap <Leader>/ :Lines!<CR>
      nnoremap <Leader>fh :History!<CR>

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

      autocmd FileType *.md Copilot disable
      let g:copilot_no_tab_map = v:true
      imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")
      imap <silent> <C-r> <Plug>(copilot-suggest)
      nmap <silent> <leader>, :Copilot enable<CR>
      nmap <silent> <leader>. :Copilot enable<CR>

      " coc config
      let g:coc_node_path='${pkgs.nodejs}/bin/node'
      let g:coc_global_extensions = [
                  \'coc-marketplace',
                  \'coc-dictionary',
                  \'coc-biome',
                  \'coc-eslint',
                  \'coc-go',
                  \'coc-clangd',
                  \'coc-highlight',
                  \'coc-json',
                  \'coc-lists',
                  \'coc-markdownlint',
                  \'coc-word',
                  \'coc-pairs',
                  \'coc-sh',
                  \'coc-snippets',
                  \'coc-sumneko-lua',
                  \'coc-tag',
                  \'coc-tsserver',
                  \'coc-typos',
                  \'coc-xml',
                  \'coc-css',
                  \'coc-yaml',
                  \'coc-pyright',
                  \]
      let g:coc_snippet_next = '<tab>'

      inoremap <silent><expr> <Tab>
                        \ coc#pum#visible() ? coc#pum#next(1):
                        \ CheckBackspace() ? "\<Tab>" :
                        \ coc#expandableOrJumpable() ?
                        \"\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',\'\'])\<CR>" :
                        \ NextCharIsPair() ? "\<Right>" :
                        \ <SID>check_back_space() ?
                        \"\<TAB>" :
                        \ coc#refresh()
      inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

      nnoremap <silent><nowait> <Leader>d :<C-u>CocDiagnostics<CR>
      nnoremap <silent><nowait> <Leader>o :<C-u>CocOutline<CR>
      nnoremap <silent><nowait> <Leader>s :<C-u>CocList -I symbols<cr>

      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)

      xmap <leader>a  <Plug>(coc-codeaction-selected)
      nmap <leader>a  <Plug>(coc-codeaction-selected)
      nmap <leader>ac  <Plug>(coc-codeaction-cursor)
      nmap <leader>as  <Plug>(coc-codeaction-source)
      nmap <leader>qf  <Plug>(coc-fix-current)

      nmap <leader>rn <Plug>(coc-rename)
      nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
      xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
      nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

      nmap <leader>cl  <Plug>(coc-codelens-action)

      xmap if <Plug>(coc-funcobj-i)
      omap if <Plug>(coc-funcobj-i)
      xmap af <Plug>(coc-funcobj-a)
      omap af <Plug>(coc-funcobj-a)
      xmap ic <Plug>(coc-classobj-i)
      omap ic <Plug>(coc-classobj-i)
      xmap ac <Plug>(coc-classobj-a)
      omap ac <Plug>(coc-classobj-a)

      nnoremap <silent> K :call ShowDocumentation()<CR>
      function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
          call CocActionAsync('doHover')
        else
          call feedkeys('K', 'in')
        endif
      endfunction

      autocmd CursorHold * silent call CocActionAsync('highlight')

      xmap <leader>f  <Plug>(coc-format-selected)
      nmap <leader>f  <Plug>(coc-format-selected)

      augroup mygroup
        autocmd!
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      augroup end

      inoremap <silent><expr> <CR> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm()
                        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
      inoremap <silent><expr> <backspace> coc#pum#visible() ? "\<bs>\<c-r>=coc#start()\<CR>" : "\<bs>"

      nmap <silent> <C-s> <Plug>(coc-range-select)
      xmap <silent> <C-s> <Plug>(coc-range-select)

      function! CheckBackspace() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      function! NextCharIsPair() abort
            let col = col('.') - 1
            let l:next_char = getline('.')[col]
            return l:next_char =~# ')\|]\|}\|>\|\'\'\|"\|`'
      endfunction

      command! -nargs=0 Format :call CocActionAsync('format')
      command! -nargs=? Fold :call     CocAction('fold', <f-args>)
      command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

      set statusline^=%{coc#status()}%{get(b:,'coc_current_function',\'\')}

      autocmd vimenter * ++nested colorscheme gruvbox
    '';
  };

  home.file.".vim" = {
    source = ./config/.vim;
    recursive = true;
    executable = true;
  };
}

