{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      # vim-system-copy
      # vim-instant-markdown
      fzf-vim
      fzfWrapper
      typst-vim
      nerdtree
      # nerdtree-visual-selection
      tcomment_vim
      vim-surround
      coc-nvim
      vim-snippets
      copilot-vim
      gruvbox
      vim-airline
      vim-airline-themes
    ];
  };
  home.file.".vimrc".source = ./config/.vimrc;
  home.file."./.vim" = {
    source = ./config/.vim;
    recursive = true;
  };

}
