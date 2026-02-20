/**
 * system/common/security.nix
 * System security configurations.
 * Includes Polkit, sudo-rs, and credential management tools.
 */
{pkgs, ...}: {
  security = {
    # Enable Polkit for privilege management
    polkit.enable = true;

    # Real-time kit for audio/gaming performance
    rtkit.enable = true;

    # Modern sudo replacement written in Rust
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = false; # Allow passwordless sudo for users in the 'wheel' group
    };
  };

  # GNOME Keyring for credential storage
  services.gnome = {
    gnome-keyring.enable = true;
  };

  # Seahorse: GUI for managing GNOME Keyring and GPG keys
  programs.seahorse.enable = true;

  # Ensure GNOME Keyring is unlocked on login via greetd
  security.pam.services.greetd.enableGnomeKeyring = true;
}
