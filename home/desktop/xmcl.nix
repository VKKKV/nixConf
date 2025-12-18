{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.xmcl.homeModules.xmcl
  ];

  programs.xmcl = {
    enable = true;
    commandLineArgs = [
      "--password-store=\"gnome-libsecret\""
    ];
    jres = [
      pkgs.zulu8
      pkgs.zulu17
      pkgs.zulu21
    ];
  };
}
