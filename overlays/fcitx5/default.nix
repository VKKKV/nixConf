_:
(_: super: {
  rime-data = ./rime-shuangpin-fuzhuma;
  fcitx5-rime = super.fcitx5-rime.override { rimeDataPkgs = [ ./rime-shuangpin-fuzhuma ]; };
  flypy-squirrel = ./rime-shuangpin-fuzhuma;
})
