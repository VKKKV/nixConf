{ pkgs, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules
  ];

  # Disabled conflicting power management daemon
  services.power-profiles-daemon.enable = false;

  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    powertop
    cpupower-gui  # Included for visualization but TLP handles actual configuration
  ];

  services = {
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main.capslock = "overload(control,esc)";
          };
        };
      };
    };

    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "PowerOff";
    };

    # Tuned TLP settings
    tlp = {
      enable = true;
      settings = {
        TLP_DEFAULT_MODE = "BAT";
        TLP_PERSISTENT_DEFAULT = 1;

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;  # Increased from 20 for better responsiveness

        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "powersave";

        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersupersave";
      };
    };

    thermald.enable = true;      # Intel thermal management
    acpid.enable = true;         # Handle ACPI events
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

  # Configure power management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";  # Overridden by TLP when switching modes
    powertop.enable = true;          # Apply power saving tweaks at boot
  };

  # Configure lid switch behavior
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "ignore";
  };

  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];
    # Load required kernel parameters
    kernelParams = [ "mem_sleep_default=deep" ];  
  };

  # Optimize system parameters
  boot.kernel.sysctl = {
    "vm.swappiness" = 20;           # Reduce swap aggressiveness
    "vm.dirty_writeback_centisecs" = 1500;  # Longer writeback intervals
    "power.suspend_mode" = "deep";         # Better suspend state
  };
}

