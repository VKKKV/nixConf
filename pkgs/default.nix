{
  inputs,
  pkgs,
  system,
  ...
}:
{
  rime-shuangpin-fuzhuma = pkgs.callPackage ./rime-shuangpin-fuzhuma { };
}
