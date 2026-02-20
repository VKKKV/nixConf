/**
 * home.nix
 * Entry point for Home Manager and user-specific configurations.
 * Manages user accounts, groups, and shell settings.
 */
{
  pkgs,
  inputs,
  username,
  host,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs username host;};
    users.${username} = {
      imports = [../../../home];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "25.11";
      programs.home-manager.enable = true;
    };
    backupFileExtension = "hm-backup";
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "users"
      "adbusers" # android debugging
      "input"
      "kvm"
      "libvirt"
      "networkmanager"
      "plugdev"
      "podman"
      "vboxusers"
      "video"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.fish;
  };

  nix.settings.allowed-users = ["${username}"];
}
