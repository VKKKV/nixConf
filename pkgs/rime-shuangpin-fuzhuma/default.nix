{
  stdenvNoCC,
  fetchFromGitHub,
  gitUpdater,
  librime,
  rime-data,
}:

stdenvNoCC.mkDerivation rec {
  pname = "rime-shuangpin-fuzhuma";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "VKKKV";
    repo = "rime-shuangpin-fuzhuma";
    tag = "${version}";
    hash = "sha256-Dz+jAa46iU4/gXVpDTzQRzzQfl97knGGON7Kmq4v/3M=";
  };

  nativeBuildInputs = [
    librime
  ];

  buildInputs = [
    rime-data
  ];

  dontConfigure = true;

  buildPhase = ''
    runHook preBuild

    for s in *.schema.yaml; do
        rime_deployer --compile "$s" . ${rime-data}/share/rime-data ./build
    done

    rm build/*.txt

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    rm -rf \
      .github \
      squirrel.yaml \
      *.trime.yaml

    mkdir -p "$out/share/rime-data"

    cp -r * "$out/share/rime-data"

    runHook postInstall
  '';

  passthru.updateScript = gitUpdater { };
}
