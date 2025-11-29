{pkgs, ...}: {
  security = {
    # security with polkit
    polkit.enable = true;

    rtkit.enable = true;

    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = false;
    };
  };

  services.gnome = {
    gnome-keyring.enable = true;
  };

  # security with gnome-kering
  # seahorse is a GUI App for GNOME Keyring.
  programs.seahorse.enable = true;

  security.pam.services.greetd.enableGnomeKeyring = true;
}
