/**
 * home/common/ssh.nix
 * SSH client and agent configuration.
 */
{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };

  # Enable the SSH agent service for managing keys
  services.ssh-agent.enable = true;
}
