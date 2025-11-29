{
  pkgs ? import <nixpkgs> { },
}:
{
  rime-shuangpin-fuzhuma = pkgs.callPackage ./rime-shuangpin-fuzhuma { };
}
