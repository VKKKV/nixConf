/**
 * home/common/gui/default.nix
 * GUI applications and desktop utilities.
 */
{...}: {
  imports = [
    ./browser.nix
    ./discord.nix
    ./fcitx5
    ./mpv
    ./vscodium
    ./yazi.nix
    ./zathura.nix
  ];
}
