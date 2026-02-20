/**
 * home/common/dev/vim/default.nix
 * Standard Vim configuration with curated plugins and settings.
 */
{pkgs, ...}: {
  programs.vim = {
    enable = true;
    # defaultEditor = true;
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
    '';
  };
}
