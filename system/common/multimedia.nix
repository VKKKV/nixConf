{
  pkgs,
  inputs,
  ...
}: {
  # --- Multimedia & Apps ---
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
  };
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  environment.systemPackages = with pkgs; [
    # Gaming
    bottles
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
    # Virtualization
    qemu_kvm
    qemu
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-spice
    adwaita-icon-theme
    # Audio Production
    reaper
    reaper-reapack-extension
    reaper-sws-extension
    raysession
    sfizz
    vital
    lsp-plugins
    dragonfly-reverb
  ];
}
