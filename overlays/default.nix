{
  self,
  ...
}:
let

in
{
  flake.overlays = {

    my-rime-data = (
      final: prev: {
        rime-data = prev.rime-shuangpin-fuzhuma;
      }
    );

    default =
      let
        overlays = [
          self.overlays.my-rime-data
        ];
      in
      (final: prev: prev.lib.composeManyExtensions overlays self prev);
  };
}
