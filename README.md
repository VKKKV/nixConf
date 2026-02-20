# NixOS Configuration

My personal NixOS configuration using Flakes and Home Manager, optimized for both performance and portability.

## 🚀 Quick Start

### Installation
```bash
# Clone the repository
git clone https://github.com/VKKKV/nixConf.git ~/nixConf

# Link to /etc/nixos
sudo ln -s ~/nixConf /etc/nixos

# Build and switch
sudo nixos-rebuild switch --flake .#laptop  # or .#desktop
```

## 📂 Structure
- **`hosts/`**: Host-specific configurations (laptop/desktop).
- **`system/`**: System-level modules organized by category (core, hardware, apps).
- **`home/`**: User-level Home Manager modules (shells, gui, dev, terminals).
- **`pkgs/`**: Custom Nix packages.
- **`wallpapers/`**: Curated system wallpapers.

## 🛠 Tech Stack
- **OS**: NixOS (Unstable)
- **WM**: Hyprland
- **Shell**: Fish & Bash (Starship prompt)
- **Terminal**: Ghostty & Kitty (Tmux)
- **Editor**: VS Codium, NixVim, Vim
- **Theme**: Stylix (Gruvbox Dark)
- **File Manager**: Yazi & Thunar
- **Browser**: Zen Browser

## 📚 Documentation
Detailed information for AI agents and developers can be found in [GEMINI.md](./GEMINI.md).
