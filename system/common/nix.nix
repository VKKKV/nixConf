{...}: {
  nix = {
    channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.

    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      trusted-users = [
        "root"
        "@wheel"
      ];

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
