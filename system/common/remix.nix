{pkgs, ...}: {
  environment = {
    # 怎么有人会用 nix 做音乐？？？？？？？？？？？
    systemPackages = with pkgs; [
      # the best unfree but free daw
      reaper

      # plugins for reaper
      reaper-reapack-extension
      reaper-sws-extension

      # session manager for musical programs
      raysession

      # vst plugins
      # kontact ?
      decent-sampler
      sfizz

      # vcv rack ?
      cardinal
      vital

      # fabfilter ?
      lsp-plugins
      dragonfly-reverb
      # calf

      # vocaloid ?
      openutau
    ];
  };
}
