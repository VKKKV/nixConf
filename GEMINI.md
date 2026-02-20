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
*   **`home.nix`**: Entry point for Home Manager and user account settings.
*   **`hosts/`**: Host-specific configurations.
    -   `hosts/<hostname>/default.nix`: Main host configuration file. Imports hardware configuration and system modules.
    -   `hosts/<hostname>/hardware-configuration.nix`: Hardware-specific scan results.
*   **`system/`**: System-wide NixOS modules (root/OS level).
    -   `system/common/`: Shared system configurations (core packages, boot, network, security, fonts, etc.).
    -   `system/common/stylix/`: System theming using `stylix`.
*   **`home/`**: Home Manager configurations (user level).
    -   `home/default.nix`: Entry point for user-level modules.
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
*   **Check Syntax:**
    ```bash
    nix flake check
    ```

## Code Style & Development Conventions

### Formatting
- All `.nix` files should be formatted with `alejandra`.
- Use 2-space indentation and consistent bracket/comma style.

### Imports & Structure
- Group imports in order: (1) inputs, (2) pkgs/config, (3) local modules.
- Use `{pkgs, inputs, username, ...}:` destructuring.
- Module structure: `{...}: { imports = [...]; }` pattern with logical separation per-feature.
- Use `let ... in` for computed values, placed before the main attribute set.

### Naming & Organization
- Use kebab-case for files (`my-module.nix`).
- Use camelCase for attributes.
- Use descriptive names for let bindings.
- Organization: System-level in `system/`, user-level in `home/`, host-specific in `hosts/`, custom packages in `pkgs/`.

### Documentation & Strings
- **Comments:** Chinese comments are acceptable, but prefer English for complex logic. Include source URLs for custom configs.
- **Headers:** Every `.nix` module should have a descriptive comment header at the top.
- **Strings:** Multi-line with `''...''`, inline with quotes. Use `${...}` interpolation for variables.
- **Lists:** Trailing items without commas in `with pkgs; [...]` blocks, use one item per line for readability.

## Infrastructure & Mirrors
- **Mirrors:** The configuration is set up to use Chinese mirrors (NJU, SJTU, TUNA) for binary caches and flake inputs. Respect these settings in `flake.nix` and system configs.
- **Modularity:**
    - System-level settings go into `system/`.
    - User-level settings go into `home/`.
    - Keep host-specific overrides in `hosts/<hostname>/`.
- **Secrets:** Be careful not to commit actual secrets (API keys, passwords) directly if not using a secret management solution (like sops-nix).

## Key Components
- **Shells:** The user uses `fish` and `bash`.
- **WindowManager:** Hyprland is the primary window manager (configured in `home/desktop/hyprlandLaptop` and `system/common/core.nix`).
- **Tooling:** The `nh` tool is enabled for better Nix CLI experience and garbage collection.
- **Theming:** `stylix` is used for global theming (configured in `system/common/stylix`).
- **Virtualization:** Podman is preferred over Docker; Libvirt/QEMU for VMs.
