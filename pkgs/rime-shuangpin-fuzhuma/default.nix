{
  stdenvNoCC,
  inputs,
}:
stdenvNoCC.mkDerivation {
  pname = "rime-shuangpin-fuzhuma";
  version = "1.0.7";

  src = inputs.rime;

  installPhase = ''
    runHook preInstall

    rm -rf .github

    mv default.yaml moqi_suggested_default.yaml

    mkdir -p $out/share/
    cp -r . $out/share/rime-data

    runHook postInstall
  '';

  meta = {
    longDescription = ''
      The upstream `default.yaml` is included as
      `moqi_suggested_default.yaml`. To enable it, please modify your
      `default.custom.yaml` as such:

      ```yaml
      patch:
        __include: moqi_suggested_default:/
      ```
    '';
  };
}
