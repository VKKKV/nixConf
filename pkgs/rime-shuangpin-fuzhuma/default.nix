{
  fetchFromGitHub,
  stdenv,
}:

stdenv.mkDerivation {
  pname = "rime-shuangpin-fuzhuma";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "gaboolic";
    repo = "rime-shuangpin-fuzhuma";
    tag = "1.0.3";
    # sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  installPhase = ''
    runHook preInstall

    rm -rf .git*

    mkdir -p $out/share

    cp -r . $out/share/rime-data

    runHook postInstall
  '';
}
