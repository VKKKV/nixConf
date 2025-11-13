{ pkgs, ... }:
{

  programs.vim = {
    enable = true;
    defaultEditor = true;
    # plugins = with pkgs.vimPlugins; [
    #   fzf-vim
    #   fzfWrapper
    #   typst-vim
    #   nerdtree
    #   tcomment_vim
    #   vim-surround
    #   coc-nvim
    #   vim-snippets
    #   copilot-vim
    #   gruvbox
    #   vim-airline
    #   vim-airline-themes
    # ];
  };
  #xdg.configFile.".vim" = {
    #source = ./config/.vim;
    #recursive = true;
    #executable = true;
  #};
#
  #xdg.configFile.".vimrc" = {
    #source = ./config/.vimrc;
  #};
}
