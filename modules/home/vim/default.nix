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
  };

  home.file.".vimrc".source = ./config/.vimrc;
  home.file.".vim" = {
    source = ./config/.vim;
    recursive = true;
    executable = true;
  };
}
