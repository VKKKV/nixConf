{
  pkgs,
  username,
  ...
}: {
  # Add user to libvirtd group
  users.users.${username}.extraGroups = ["libvirtd"];

  # Enable nested virtualization, required by security containers and nested vm.
  # This should be set per host in /hosts, not here.
  #
  ## For AMD CPU, add "kvm-amd" to kernelModules.
  # boot.kernelModules = ["kvm-amd"];
  # boot.extraModprobeConfig = "options kvm_amd nested=1";  # for amd cpu
  #
  ## For Intel CPU, add "kvm-intel" to kernelModules.
  # boot.kernelModules = ["kvm-intel"];
  # boot.extraModprobeConfig = "options kvm_intel nested=1"; # for intel cpu

  # GPU passthrough
  # boot.kernelModules = [ "vfio-pci" ];

  environment.systemPackages = with pkgs; [
    qemu_kvm
    qemu
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
  ];

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
      #   # hanging this option to false may cause file permission issues for existing guests.
      #   # To fix these, manually change ownership of affected files in /var/lib/libvirt/qemu to qemu-libvirtd.
      #   qemu.runAsRoot = true;
    };
    spiceUSBRedirection.enable = true;

    docker.enable = false;
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
      # Periodically prune Podman resources
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = ["--all"];
      };
    };

    oci-containers = {
      backend = "podman";
    };

    # Usage: https://wiki.nixos.org/wiki/Waydroid
    # waydroid.enable = true;

    # lxd.enable = true;
  };

  services.spice-vdagentd.enable = true;
}
