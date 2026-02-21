# NixOS Configuration ❄️

A modular, performant, and aesthetic NixOS configuration using **Flakes** and **Home Manager**. Designed for a seamless workflow across high-performance desktop and power-optimized laptop environments.

> [!CAUTION]
> **Important Notice:** This repository is highly customized for my specific hardware (AMD/NVIDIA Desktop & Intel Laptop). It is **not** intended to be used directly on other machines without significant modification. Use it as a reference, not a plug-and-play solution.

## ✨ Key Features

- **Window Managers:** Dual-setup with **Hyprland** (performance) and **Niri** (scroll-based).
- **Global Theming:** Unified **Gruvbox Dark** aesthetics powered by **Stylix**.
- **Dev Environment:** Fully synchronized **Nixvim** configuration with JDTLS, Blink-cmp, and Copilot.
- **Browsing:** Privacy-hardened **Zen Browser** with declarative extension management.
- **Hardware Optimized:** Decoupled modules for AMD/Intel CPUs and NVIDIA/Intel GPUs.
- **System Management:** Simplified maintenance with **nh** (Nix Helper) and automated garbage collection.

## 🚀 Quick Start

### 1. Prerequisites
Ensure you have Nix installed with experimental features (`nix-command` and `flakes`) enabled.

### 2. Installation
```bash
# Clone the repository
git clone https://github.com/VKKKV/nixConf.git ~/code/nixConf

# Build and switch (Default profile is 'laptop')
sudo nixos-rebuild switch --flake .#laptop
```

## 📂 Repository Structure

The configuration is organized for maximum modularity and minimum directory clutter:

- **`hosts/`**: Entry points for specific machines (`desktop`, `laptop`).
- **`system/`**: System-level NixOS modules (Boot, Networking, Services, Hardware).
- **`home/`**: User-level Home Manager configurations.
  - **`common/`**: Shared applications (Shells, GUI, Dev Tools, Terminals).
  - **`desktop/`**: Window manager specific settings (Hyprland, Niri, Waybar).
- **`pkgs/`**: Custom Nix expressions and local packages.
- **`wallpapers/`**: Curated system-wide wallpapers.

## 🛠 Tech Stack

| Category | Tools |
| :--- | :--- |
| **Shell** | Fish (Main), Bash, Starship Prompt, Atuin, Zoxide |
| **Terminals** | Ghostty, Kitty, Tmux |
| **Editors** | Nixvim (declarative NeoVim), VSCodium, Vim |
| **File Manager** | Yazi, Thunar |
| **Apps** | Discord (WebCord), MPV, Zathura, OBS Studio, Lutris |
| **Input** | Fcitx5 (Rime-Shuangpin) |

## 📖 Documentation

For more detailed architectural insights and development conventions, refer to [GEMINI.md](./GEMINI.md).
