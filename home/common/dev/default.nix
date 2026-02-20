/**
 * home/common/dev/default.nix
 * Development tools and environment.
 */
{...}: {
  imports = [
    ./git.nix
    ./ssh.nix
    ./nixvim
    ./vim
  ];
}
