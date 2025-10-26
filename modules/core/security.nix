{ ... }:
{
  security = {
    # rtkit is optional but recommended
    # Whether to enable the RealtimeKit system service, which hands out realtime scheduling priority to user processes on demand. For example, PulseAudio and PipeWire use this to acquire realtime priority.
    rtkit.enable = true;
    sudo.enable = true;

    # pam.services = {
    #   swaylock = { };
    #   hyprlock = { };
    # };
  };
}
