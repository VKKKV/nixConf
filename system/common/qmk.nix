/**
 * system/common/qmk.nix
 * QMK Keyboard configuration.
 * Provides tools and udev rules for QMK-compatible keyboards.
 */
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    via
    vial
    qmk
    qmk-udev-rules
  ];

  services.udev.packages = with pkgs; [
    via
    vial
    qmk-udev-rules
  ];
}
