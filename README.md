# memo

nix-channel --add https://mirror.nju.edu.cn/nix-channels/nixos-25.05 nixos

nix-channel --update

nixos-install --option substituters "https://mirror.nju.edu.cn/nix-channels/store https://cache.nixos.org"

nixos-rebuild --option substituters "https://mirror.nju.edu.cn/nix-channels/store https://cache.nixos.org"

nix.settings.substituters = [ "https://mirror.nju.edu.cn/nix-channels/store" ];

``` shell
git clone git@github.com:VKKKV/nixConf.git --config "http.proxy=192.168.0.106:7897"

sudo mv /etc/nixos /etc/nixos.bak

sudo ln -s ~/nixConf /etc/nixos

sudo nixos-rebuild switch --flake .#laptop --option substituters "https://mirror.nju.edu.cn/nix-channels/store https://cache.nixos.org"
```

```nix
home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

home.file.".config/i3/scripts" = {
  source = ./scripts;
  recursive = true;   # 递归整个文件夹
  executable = true;  # 将其中所有文件添加「执行」权限
};

home.file.".xxx".text = ''
    xxx
'';
```

