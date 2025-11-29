{
  stdenvNoCC,
  inputs,
}:
stdenvNoCC.mkDerivation {
  pname = "rime-shuangpin-fuzhuma";

  src = inputs.rime;

  installPhase = ''
    runHook preInstall

    rm -rf \
      .github \

    mkdir -p $out/share/

    cp -r . $out/share/rime-data

    runHook postInstall
  '';
}
