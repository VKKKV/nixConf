# NixOS Configuration

My personal NixOS configuration using Flakes and Home Manager.

## 🚀 Quick Start

### Installation
```bash
# Clone the repository
git clone https://github.com/VKKKV/nixConf.git ~/nixConf

# Symbol link to /etc/nixos
sudo ln -s ~/nixConf /etc/nixos

# Build and switch for laptop
sudo nixos-rebuild switch --flake .#laptop

# Build and switch for desktop
sudo nixos-rebuild switch --flake .#desktop
```

### Maintenance
```bash
# Update flake inputs
nix flake update

# Garbage collection (using nh)
sudo nh clean

# Format code
alejandra .
```

## 💻 Hardware
- **Laptop**: RedmiBook Pro 15 (Power-optimized with TLP)
- **Desktop**: Performance-oriented configuration

## 🛠 Tech Stack
- **OS**: NixOS (Unstable)
- **WM**: Hyprland
- **Shell**: Fish / Bash
- **Terminal**: Ghostty / Kitty
- **Editor**: VS Codium / NixVim / Vim
- **Theme**: Stylix (Gruvbox Dark)
- **File Manager**: Yazi / Thunar
- **Browser**: Zen Browser

## 📚 Documentation
Detailed information for AI agents and developers can be found in [GEMINI.md](./GEMINI.md).

## 🙏 Credits
- [klchen0112/dotfiles](https://github.com/klchen0112/dotfiles)
- [linuxmobile/kaku](https://github.com/linuxmobile/kaku)
- [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config)
