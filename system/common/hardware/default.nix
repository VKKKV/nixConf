{pkgs, ...}: {
  /**
   * system/common/hardware/default.nix
   * Consolidated common hardware-related configurations.
   */

  # --- Bluetooth Configuration ---
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez5-experimental;
    powerOnBoot = true;
    settings.General = {
      Experimental = true;
      FastConnectable = true;
      JustWorksRepairing = "always";
      Privacy = "device";
    };
  };
  services.fwupd.enable = true;

  # --- QMK & Keyboard Tools ---
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
