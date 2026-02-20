# NixOS Configuration Context (GEMINI)

This document provides context for AI agents working with this NixOS configuration repository.

## Project Overview

This is a NixOS configuration project using **Nix Flakes**. It manages the system state and user environments for multiple machines (hosts) declaratively.

-   **Primary User:** `kita`
-   **Platform:** x86_64-linux
-   **Hosts:**
    -   `desktop`: Performance-oriented configuration.
    -   `laptop`: Power-optimized configuration (RedmiBook Pro 15) using TLP and specific power management settings.

## Directory Structure

*   **`flake.nix`**: The entry point. Defines inputs (nixpkgs, home-manager, etc.) and outputs (nixosConfigurations).
*   **`hosts/`**: Host-specific configurations.
    -   `hosts/<hostname>/default.nix`: Main host configuration file.
    -   `hosts/<hostname>/hardware-configuration.nix`: Hardware-specific scan results.
*   **`system/`**: System-wide NixOS modules (root/OS level).
    -   **`system/common/core/`**: Essential system settings (boot, nix, network, security, services, xdg) and user/Home-Manager setup.
    -   **`system/common/hardware/`**: Hardware-specific configurations (bluetooth, graphics, QMK).
    -   **`system/common/apps/`**: System-level applications (flatpak, virtualization, gaming tools, fonts).
    -   **`system/common/stylix/`**: Global system theming using `stylix`.
*   **`home/`**: Home Manager configurations (user level).
    -   **`home/common/core/`**: Core user utilities (btop, bat, tealdeer, xdg-mimes).
    -   **`home/common/shells/`**: Shell configurations (bash, fish, starship, atuin, fzf, zoxide).
    -   **`home/common/gui/`**: Graphical applications (browser, discord, mpv, vscodium, yazi, zathura, fcitx5).
    -   **`home/common/terminals/`**: Terminal emulators (ghostty, kitty, tmux).
    -   **`home/common/dev/`**: Development environment (git, ssh, nixvim, vim).
    -   **`home/desktop/`**: GUI-related user configuration (Hyprland, waybar, rofi, etc.).
*   **`pkgs/`**: Custom packages not found in nixpkgs (e.g., `rime-shuangpin-fuzhuma`).
*   **`wallpapers/`**: System wallpapers.

## Key Commands

### Building and Switching
Apply the configuration for a specific host:
```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

### Maintenance
*   **Garbage Collection:** `sudo nh clean` or `nix-collect-garbage -d`
*   **Update Inputs:** `nix flake update`
*   **Format Code:** `alejandra .`

## Code Style & Development Conventions

### Formatting & Structure
- All `.nix` files should be formatted with `alejandra`.
- **Modularity:** Configurations are grouped by category into subdirectories with `default.nix` as the entry point for each group.
- **Headers:** Every `.nix` module should have a descriptive comment header.

### Infrastructure & Mirrors
- **Mirrors:** Uses Chinese mirrors (NJU, SJTU, TUNA) for binary caches and flake inputs. Respect these in `flake.nix` and `system/common/core/nix.nix`.

## Key Components
- **Shells:** Primary shells are `fish` and `bash`.
- **WindowManager:** Hyprland is the primary window manager (configured in `home/desktop/hyprland`).
- **Tooling:** `nh` for Nix CLI experience; `stylix` for global theming.
- **Virtualization:** Podman (containers) and Libvirt/QEMU (VMs).
