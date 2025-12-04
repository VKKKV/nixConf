Under construction

copy start 👅👅👅

orz omg

https://github.com/klchen0112/dotfiles

https://github.com/linuxmobile/kaku

https://github.com/Frost-Phoenix/nixos-config

stylix! awesome!

# memo

``` shell
sudo systemctl reboot --firmware-setup

# change --root when root partition mount point is not /mnt

nix-collect-garbage -d

nixos-generate-config --root /mnt

git clone git@github.com:VKKKV/nixConf.git --config "http.proxy=192.168.0.106:7897"

sudo mv /etc/nixos /etc/nixos.bak

sudo ln -s ~/nixConf /etc/nixos

cp hardware-configuration.nix hosts/laptop/hardware-configuration.nix

sudo nixos-rebuild switch --flake .#laptop --option substituters "https://mirror.nju.edu.cn/nix-channels/store https://cache.nixos.org"

nixos-rebuild switch --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
nixos-rebuild switch --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store"
nixos-rebuild switch --option substituters "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

sudo nixos-install --root /mnt

sudo nixos-install --root /mnt --flake .#laptop --option substituters "https://mirror.nju.edu.cn/nix-channels/store https://cache.nixos.org"

sudo mkdir -p /run/systemd/system/nix-daemon.service.d/
sudo tee /run/systemd/system/nix-daemon.service.d/override.conf << EOF
[Service]
Environment="https_proxy=socks5h://192.168.0.106:7897"
EOF
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon

# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  hello = pkgs.callPackage ./hello.nix { };
}

nix-build -A hello

nix-prefetch-url --unpack https://github.com/atextor/icat/archive/refs/tags/v0.5.tar.gz --type sha256

rg -i "libx11 =" pkgs

```

```nix
nix.settings.substituters = [ "https://mirror.nju.edu.cn/nix-channels/store" ];

home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

home.file.".config/i3/scripts" = {
  source = ./scripts;
  recursive = true;   # 递归整个文件夹
  executable = true;  # 将其中所有文件添加「执行」权限
};

home.file.".xxx".text = ''
    xxx
'';

xdg.configFile."test" = {
    source = ./config;
    recursive = true;
    executable = true;
};

xdg.dataFile."test" = {
    source = ./config;
    recursive = true;
    executable = true;
};

```

