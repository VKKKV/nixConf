{
  pkgs,
  inputs,
  username,
  ...
}: {
  /**
   * system/common/apps/default.nix
   * Consolidated system-wide applications, gaming, and virtualization.
   */

  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.platformOptimizations
    inputs.aagl.nixosModules.default
  ];

  # --- Flatpak ---
  xdg.portal.enable = true;
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    overrides.global.Context.sockets = ["wayland" "!x11" "!fallback-x11"];
  };

  # --- Fonts ---
  fonts = {
    packages = with pkgs; [
      material-design-icons font-awesome
      nerd-fonts.symbols-only nerd-fonts.fira-code nerd-fonts.jetbrains-mono nerd-fonts.iosevka
      noto-fonts noto-fonts-color-emoji noto-fonts-cjk-sans noto-fonts-cjk-serif
      source-sans source-serif source-han-sans source-han-serif source-han-mono
      lxgw-wenkai-screen maple-mono.NF-CN-unhinted
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {enable = true; autohint = false; style = "full";};
      subpixel = {lcdfilter = "default"; rgba = "rgb";};
      defaultFonts = {
        serif = ["Source Han Serif SC" "Source Serif 4" "Source Han Serif TC"];
        sansSerif = ["LXGW WenKai Screen" "Source Sans 3" "Source Han Sans SC" "Source Han Sans TC"];
        monospace = ["Maple Mono NF CN" "JetBrainsMono Nerd Font" "Source Han Mono SC" "Source Han Mono TC"];
        emoji = ["Noto Color Emoji"];
      };
      cache32Bit = true;
    };
    enableDefaultPackages = false;
    fontDir = {enable = true; decompressFonts = true;};
  };

  services.kmscon = {
    enable = true;
    fonts = with pkgs; [
      {name = "Maple Mono NF CN"; package = maple-mono.NF-CN-unhinted;}
      {name = "Source Han Mono SC"; package = source-han-mono;}
      {name = "JetBrainsMono Nerd Font"; package = nerd-fonts.jetbrains-mono;}
    ];
    extraOptions = "--term xterm";
    extraConfig = "font-size=19";
    hwRender = true;
  };

  # --- Gaming ---
  aagl.enableNixpkgsReleaseBranchCheck = false;
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      extest.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
      fontPackages = [pkgs.wqy_zenhei];
      platformOptimizations.enable = true;
    };
    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
      args = ["--rt" "--expose-wayland"];
    };
    anime-game-launcher.enable = true;
    honkers-railway-launcher.enable = true;
    sleepy-launcher.enable = true;
  };
  services.pipewire.lowLatency = {
    enable = true;
    quantum = 32;
    rate = 48000;
  };

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
      autoPrune = {enable = true; dates = "weekly"; flags = ["--all"];};
    };
    oci-containers.backend = "podman";
  };
  services.spice-vdagentd.enable = true;

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
    qemu_kvm qemu virt-manager virt-viewer spice spice-gtk spice-protocol win-spice adwaita-icon-theme
    # Audio Production
    reaper reaper-reapack-extension reaper-sws-extension raysession sfizz vital lsp-plugins dragonfly-reverb
  ];

  # --- Minecraft ---
  services.minecraft-servers = {
    enable = false;
    eula = true;
    openFirewall = true;
    servers.fabric = {
      enable = false;
      package = pkgs.fabricServers.fabric-1_21_1.override {loaderVersion = "0.16.10";};
      symlinks.mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
        Fabric-API = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/9YVrKY0Z/fabric-api-0.115.0%2B1.21.1.jar";
          sha512 = "e5f3c3431b96b281300dd118ee523379ff6a774c0e864eab8d159af32e5425c915f8664b1cd576f20275e8baf995e016c5971fea7478c8cb0433a83663f2aea8";
        };
        Backpacks = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/MGcd6kTf/versions/Ci0F49X1/1.2.1-backpacks_mod-1.21.2-1.21.3.jar";
          sha512 = "6efcff5ded172d469ddf2bb16441b6c8de5337cc623b6cb579e975cf187af0b79291b91a37399a6e67da0758c0e0e2147281e7a19510f8f21fa6a9c14193a88b";
        };
      });
    };
  };
}
