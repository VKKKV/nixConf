# AGENTS.md - NixOS Configuration Agent Guide

## Build & Test Commands
- **Build system**: `sudo nixos-rebuild switch --flake .#laptop` or `sudo nixos-rebuild switch --flake .#desktop`
- **Test config**: `sudo nixos-rebuild test --flake .#<host>` (applies without adding boot entry)
- **Check syntax**: `nix flake check` (validates flake structure)
- **Format code**: `alejandra .` or `nixfmt **/*.nix` (alejandra is preferred, installed in system)
- **Update inputs**: `nix flake update` (updates flake.lock)
- **Garbage collect**: `nix-collect-garbage -d` or `sudo nh clean` (nh keeps last 5 generations, 7 days)
- **Single host test**: Change host in `hosts/<hostname>/default.nix` and rebuild with test flag

## Code Style Guidelines
- **Formatting**: Use `alejandra` formatter (2-space indentation, consistent bracket/comma style)
- **Imports**: Group in order: (1) inputs, (2) pkgs/config, (3) local modules. Use `{pkgs, inputs, username, ...}:` destructuring
- **Module structure**: `{...}: { imports = [...]; }` pattern with logical separation per-feature
- **Naming**: Use kebab-case for files (`my-module.nix`), camelCase for attributes, descriptive names for let bindings
- **Organization**: System-level in `system/`, user-level in `home/`, host-specific in `hosts/`, custom packages in `pkgs/`
- **Let bindings**: Use `let ... in` for computed values, place before main attribute set (see waybar/settings.nix pattern)
- **Comments**: Chinese comments acceptable, prefer English for complex logic. Include source URLs for custom configs
- **Strings**: Multi-line with `''...''`, inline with quotes. Use `${...}` interpolation for variables
- **Lists**: Trailing items without commas in `with pkgs; [...]` blocks, use one item per line for readability

## Notes
- Flake inputs use Chinese mirrors (NJU, SJTU, TUNA) for faster downloads - keep priority settings
- Two configurations: desktop (performance) and laptop (power-optimized with TLP)
- Username hardcoded as "kita" in flake.nix:10 - update if forking
