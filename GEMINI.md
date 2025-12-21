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
    -   `hosts/<hostname>/default.nix`: Main host configuration file. Imports hardware configuration and system modules.
    -   `hosts/<hostname>/hardware-configuration.nix`: Hardware-specific scan results.
*   **`system/`**: System-wide NixOS modules (root/OS level).
    -   `system/common/`: Shared system configurations (core packages, boot, network, security, fonts, etc.).
    -   `system/stylix/`: System theming using `stylix`.
*   **`home/`**: Home Manager configurations (user level).
    -   `home/default.nix`: Entry point for home-manager modules.
    -   `home/common/`: User programs and dotfiles (shell, terminal, tools).
    -   `home/desktop/`: GUI-related user configuration (Wayland/Hyprland settings).
*   **`pkgs/`**: Custom packages not found in nixpkgs (e.g., `rime-shuangpin-fuzhuma`).

## Key Commands

### Building and Switching
Apply the configuration for a specific host:
```bash
sudo nixos-rebuild switch --flake .#<hostname>
# Example: sudo nixos-rebuild switch --flake .#laptop
```

### Testing Changes
Build and activate the configuration without adding a boot entry (good for testing):
```bash
sudo nixos-rebuild test --flake .#<hostname>
```

### Maintenance
*   **Garbage Collection:**
    ```bash
    sudo nh clean
    # or
    nix-collect-garbage -d
    ```
*   **Update Inputs:**
    ```bash
    nix flake update
    ```
*   **Format Code:**
    ```bash
    alejandra .
    ```

## Development Conventions

*   **Formatting:** All `.nix` files should be formatted with `alejandra`.
*   **Mirrors:** The configuration is set up to use Chinese mirrors (NJU, SJTU, TUNA) for binary caches and flake inputs. Respect these settings in `flake.nix` and system configs.
*   **Modularity:**
    -   System-level settings go into `system/`.
    -   User-level settings go into `home/`.
    -   Keep host-specific overrides in `hosts/<hostname>/`.
*   **Secrets:** Be careful not to commit actual secrets (API keys, passwords) directly if not using a secret management solution (like sops-nix).
*   **Shells:** The user uses `fish` and `bash`.
*   **WindowManager:** Hyprland is the primary window manager (configured in `home/desktop/hyprlandLaptop` and `system/common/core.nix`).

## User Notes (from AGENTS.md)
*   Two configurations exist: `desktop` (performance) and `laptop` (power-optimized).
*   The `nh` tool is enabled for better Nix CLI experience and garbage collection.
*   `stylix` is used for global theming.
