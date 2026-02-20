# NixOS Configuration Context (GEMINI)

This document provides context for AI agents working with this NixOS configuration repository.

## Project Overview

This is a NixOS configuration project using **Nix Flakes**. It manages the system state and user environments for multiple machines (hosts) declaratively.

-   **Primary User:** `kita`
-   **Platform:** x86_64-linux
-   **Hosts:**
    -   `desktop`: Performance-oriented configuration (AMD + NVIDIA).
    -   `laptop`: Power-optimized configuration (Intel-only RedmiBook Pro 15).

## Directory Structure

*   **`flake.nix`**: The entry point. Defines inputs and outputs.
*   **`hosts/`**: Host-specific entry points and hardware scan results.
*   **`system/`**: System-wide NixOS modules.
    -   **`system/common/`**: Shared system logic (core, networking, services, stylix).
    -   **`system/hardware/`**: Decoupled hardware modules.
        -   **`cpu/`**: CPU-specific tweaks (Intel/AMD).
        -   **`gpu/`**: Graphics drivers and optimizations (NVIDIA/Intel/AMD).
        -   **`device/`**: Form-factor specific settings (Laptop/Desktop).
*   **`home/`**: Home Manager configurations.
    -   **`home/common/`**: Shared user applications and dotfiles (categorized).
    -   **`home/desktop/`**: GUI-related user configuration (Hyprland, waybar).
*   **`pkgs/`**: Custom packages.
*   **`wallpapers/`**: System wallpapers.

## Key Commands

### Building and Switching
```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

### Maintenance
*   **Garbage Collection:** `sudo nh clean` or `nix-collect-garbage -d`
*   **Update Inputs:** `nix flake update`
*   **Format Code:** `alejandra .`

## Code Style & Development Conventions

### Modularity & Hardware Decoupling
- **Hardware:** CPU, GPU, and Device type (Laptop/Desktop) are decoupled into `system/hardware/`.
- **Imports:** Host configurations should import from `system/hardware/` to match their physical components.
- **Modularity:** Configurations are grouped by category into subdirectories with `default.nix` as the entry point.

## Key Components
- **WindowManager:** Hyprland (configured in `home/desktop/hyprland`).
- **Theming:** `stylix` for global theming.
- **Power Management:** `tlp` and `powertop` for laptops.
- **Virtualization:** Podman and Libvirt/QEMU.
