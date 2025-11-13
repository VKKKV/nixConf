Under construction

# memo

``` shell
lsblk -f

nix-channel --add https://mirror.nju.edu.cn/nix-channels/nixos-25.05 nixos

nix-channel --update

nix-collect-garbage -d

# change --root when root partition mount point is not /mnt

nixos-generate-config --root /mnt

git clone git@github.com:VKKKV/nixConf.git --config "http.proxy=192.168.0.106:7897"

sudo mv /etc/nixos /etc/nixos.bak

sudo ln -s ~/nixConf /etc/nixos

cp hardware-configuration.nix hosts/laptop/hardware-configuration.nix

sudo nixos-rebuild switch --flake .#laptop --option substituters "https://mirror.nju.edu.cn/nix-channels/store https://cache.nixos.org"

sudo nixos-install --root /mnt

sudo nixos-install --root /mnt --flake .#laptop --option substituters "https://mirror.nju.edu.cn/nix-channels/store https://cache.nixos.org"
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
```

