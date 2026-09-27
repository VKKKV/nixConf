{
  pkgs,
  username,
  ...
}: {
  # --- Virtualization ---
  users.users.${username}.extraGroups = ["libvirtd"];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
    spiceUSBRedirection.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = ["--all"];
      };
    };
    oci-containers.backend = "podman";
  };
  services.spice-vdagentd.enable = true;
}
