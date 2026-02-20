/**
 * hosts/laptop/default.nix
 * Host-specific configuration for the RedmiBook Pro 15 laptop.
 * Focused on power optimization, thermal management, and portability.
 */
{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/common
    ../../home.nix
  ];

  # Disable default power profiles daemon in favor of TLP
  services.power-profiles-daemon.enable = false;

  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    powertop
    cpupower-gui
  ];

  services = {
    # Keyd: Advanced keyboard remapping
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main.capslock = "overload(control,esc)"; # CapsLock as Ctrl (hold) and Esc (tap)
          };
        };
      };
    };

    # UPower: Power management service
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "PowerOff";
    };

    # TLP: Advanced power management for Linux laptops
    tlp = {
      enable = true;
      settings = {
        TLP_DEFAULT_MODE = "BAT";
        TLP_PERSISTENT_DEFAULT = 1;

        # CPU Performance scaling
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # Performance limits
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;

        # Battery charging thresholds
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        # Intel GPU frequency limits
        INTEL_GPU_MIN_FREQ_ON_AC = 500;
        INTEL_GPU_MIN_FREQ_ON_BAT = 100;
        INTEL_GPU_MAX_FREQ_ON_AC = 1300;
        INTEL_GPU_MAX_FREQ_ON_BAT = 500;

        # Hardware power saving
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersupersave";

        USB_AUTOSUSPEND = 1;
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 1;
        WIFI_POWERSAVE_ON_AC = 0;
        WIFI_POWERSAVE_ON_BAT = 1;
      };
    };

    thermald.enable = true; # Intel thermal management
    acpid.enable = true; # Handle ACPI events
  };

  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
      ];
    };
  };

  # Power management tweaks
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance"; # Managed by TLP
    powertop.enable = true;
  };

  # Handle lid behavior
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  boot = {
    loader = {
      limine = {
        extraConfig = ''
          /Windows
          protocol: efi
          path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '';
      };
    };
    kernelModules = [
      "acpi_call"
      "kvm-intel"
    ];

    extraModprobeConfig = "options kvm_intel nested=1";

    kernelParams = ["mem_sleep_default=deep"];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];
  };
}
