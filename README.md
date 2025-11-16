Under construction

copy start 👅👅👅

https://github.com/linuxmobile/kaku

https://github.com/Frost-Phoenix/nixos-config

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

# 使用上海交通大学的镜像源
# 官方文档: https://mirror.sjtu.edu.cn/docs/nix-channels/store
nixos-rebuild switch --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"

# 使用中国科学技术大学的镜像源
# 官方文档: https://mirrors.ustc.edu.cn/help/nix-channels.html
nixos-rebuild switch --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store"

# 使用清华大学的镜像源
# 官方文档: https://mirrors.tuna.tsinghua.edu.cn/help/nix-channels/
nixos-rebuild switch --option substituters "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

# 其他 nix 命令同样可以使用 --option 选项，例如 nix shell
nix shell nixpkgs#cowsay --option substituters "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"


sudo nixos-install --root /mnt

sudo nixos-install --root /mnt --flake .#laptop --option substituters "https://mirror.nju.edu.cn/nix-channels/store https://cache.nixos.org"

# This hides completely the cursor.

tput civis

# To restore:

tput cnorm

sudo mkdir -p /run/systemd/system/nix-daemon.service.d/
sudo tee /run/systemd/system/nix-daemon.service.d/override.conf << EOF
[Service]
Environment="https_proxy=socks5h://192.168.0.106:7897"
EOF
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
```

```nix
{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-25.05&shallow=1";
    # nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-25.05&shallow=1";
    # nixpkgs.url = "https://mirrors.ustc.edu.cn/nix-channels/nixos-25.05/nixexprs.tar.xz";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.my-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}

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
```

