{ pkgs, ... }:
{
  services = {
    gvfs.enable = true;

    gnome = {
      tinysparql.enable = true;
      gnome-keyring.enable = true;
    };

    dbus.enable = true;
    fstrim.enable = true;

    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];

    logind.settings.Login = {
      # don’t shutdown when power button is short-pressed
      HandlePowerKey = "ignore";

      # Defaulted to false in nixpkgs because many tools that rely on persistent user processes—like tmux, screen, mosh, VNC, nohup, and more — would break by the systemd-default behavior.
      KillUserProcesses = false;
    };

    udisks2.enable = true;

    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
        # AllowUsers = [ "arch" ];
      };
    };
  };
}
