/**
 * home/desktop/swayidle.nix
 * Swayidle: Idle management daemon for Wayland.
 * Configures automatic screen locking and system suspension.
 */
{pkgs, ...}: {
  services.swayidle = {
    enable = true;
    
    # Events triggered by system signals
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
    ];

    # Timeouts for automatic actions
    timeouts = [
      {
        timeout = 90;
        command = "swaylock";
      }
      {
        timeout = 300;
        command = "systemctl suspend";
      }
    ];
  };
}
