/**
 * system/common/virtualization.nix
 * Virtualization and containerization settings.
 * Includes Libvirt/QEMU for VMs and Podman for containers.
 */
{
  pkgs,
  username,
  ...
}: {
  # Grant user access to virtualization controls
  users.users.${username}.extraGroups = ["libvirtd"];

  # Virtualization-related system packages
  environment.systemPackages = with pkgs; [
    qemu_kvm
    qemu
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-spice
    adwaita-icon-theme
  ];

  virtualisation = {
    # Libvirt configuration for QEMU/KVM Virtual Machines
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true; # Software TPM for Windows 11 compatibility
      };
    };
    spiceUSBRedirection.enable = true;

    # Podman: Daemon-less Docker-compatible container engine
    docker.enable = false;
    podman = {
      enable = true;
      dockerCompat = true; # Use podman as a drop-in 'docker' replacement
      defaultNetwork.settings.dns_enabled = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = ["--all"];
      };
    };

    oci-containers = {
      backend = "podman";
    };
  };

  # Spice agent for clipboard sharing and auto-resolution in VMs
  services.spice-vdagentd.enable = true;
}
