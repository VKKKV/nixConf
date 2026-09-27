/**
* system/common/default.nix
* Unified entry point for all common system-wide configurations.
*/
{
  lib,
  host,
  ...
}: {
  imports =
    [
      ./core.nix
      ./hardware.nix
      ./apps.nix
      ./fonts.nix
      ./stylix
    ]
    ++ lib.optionals (host == "desktop") [
      ./gaming.nix
      ./virtualization.nix
      ./multimedia.nix
    ];
}
