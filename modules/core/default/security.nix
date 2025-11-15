{...}:
{
  security = {
    rtkit.enable = true;

    # rust sudo
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = false;
    };
    # sudo.enable = true;
  };
}
