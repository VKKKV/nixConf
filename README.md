# NixOS Configuration ❄️

A modular, performant, and aesthetic NixOS configuration using **Flakes** and **Home Manager**. Designed for a seamless workflow across high-performance desktop and power-optimized laptop environments.

> [!CAUTION]
> **Important Notice:** This repository is highly customized for my specific hardware (AMD/NVIDIA Desktop & Intel Laptop). It is **not** intended to be used directly on other machines without significant modification. Use it as a reference, not a plug-and-play solution.

## ✨ Key Features

- **Window Manager:** **Hyprland**.
- **Global Theming:** Unified **Gruvbox Dark** aesthetics powered by **Stylix**.
- **Dev Environment:** Fully synchronized **Nixvim** configuration with JDTLS, Blink-cmp, and Copilot.
- **Browsing:** Privacy-hardened **Zen Browser** with declarative extension management.
- **Hardware Optimized:** Decoupled modules for AMD/Intel CPUs and NVIDIA/Intel GPUs.
- **System Management:** Simplified maintenance with **nh** (Nix Helper) and scheduled cleanup.

## 🚀 Quick Start

### 1. Prerequisites
Ensure you have Nix installed with experimental features (`nix-command` and `flakes`) enabled.

### 2. Installation
```bash
# Clone the repository
git clone https://github.com/VKKKV/nixConf.git ~/code/nix-config
cd ~/code/nix-config

# Build and switch (Default profile is 'laptop')
sudo nixos-rebuild switch --flake .#laptop
```

## 📂 Repository Structure

The configuration is organized for maximum modularity and minimum directory clutter:

- **`hosts/`**: Entry points for specific machines (`desktop`, `laptop`).
- **`system/`**: System-level NixOS modules (Boot, Networking, Services, Hardware).
- **`home/`**: User-level Home Manager configurations.
  - **`common/`**: Shared applications (Shells, GUI, Dev Tools, Terminals).
  - **`desktop/`**: Window manager specific settings (Hyprland, Waybar).
- **`pkgs/`**: Custom Nix expressions and local packages.
- **`wallpapers/`**: Curated system-wide wallpapers.

## Hosts and profiles

- `desktop`: AMD CPU, NVIDIA GPU, gaming, virtualization, multimedia and audio-production modules.
- `laptop`: Intel CPU/GPU, TLP power management and laptop-specific Hyprland display/lid settings.
- Both hosts share the common system modules, Home Manager configuration, Stylix theme and Nixvim setup.
- XMCL is enabled through `home/desktop/xmcl.nix`; it provides Java 8, 17 and 21 runtimes.

The desktop hardware file still contains a placeholder root filesystem declaration. Verify the real disks and EFI layout before deploying the desktop profile.

## Maintenance and verification

```bash
# Evaluate/check without building system closures
nix flake check --no-write-lock-file --show-trace
nix eval .#nixosConfigurations.desktop.config.system.build.toplevel.drvPath
nix eval .#nixosConfigurations.laptop.config.system.build.toplevel.drvPath

# Check formatting and shell syntax
nix build .#formatter.x86_64-linux --no-link
alejandra --check .
git diff --check
bash -n home/desktop/hyprland/config/lib/*.sh
```

`nh clean` is the configured garbage-collection entry point. Input upgrades should be reviewed separately from configuration refactors.

Security-sensitive defaults that require an explicit local decision include passwordless sudo, SSH password authentication, `allowBroken`, and globally opened firewall ports.

## 🛠 Tech Stack

Category: Shell — Fish (Main), Bash, Starship Prompt, Atuin, Zoxide
Category: Terminals — Ghostty, Kitty, Tmux
Category: Editors — Nixvim (declarative NeoVim), VSCodium, Vim
Category: File Manager — Yazi, Thunar
Category: Apps — Discord (WebCord), MPV, Zathura, OBS Studio, Lutris
Category: Input — Fcitx5 (Rime-Shuangpin)


## CTF toolkit

The common user profile includes the command-line tools used by the local CTF workspace:

- Reverse/pwn: GDB, pwndbg, radare2, rizin, ROPgadget, pwntools, checksec, Ghidra.
- Forensics/stego: binwalk, foremost, exiftool, steghide, zsteg, YARA, Volatility 3, tshark.
- Web/network: nmap, gobuster, ffuf, sqlmap, tcpdump, Wireshark/tshark.
- Crypto/passwords/VM: hashcat, John the Ripper, QEMU.
- Python-heavy tooling remains in `~/ctf/workspace` and is managed with its existing `uv` environment; the Nix profile supplies the native/system tools.
