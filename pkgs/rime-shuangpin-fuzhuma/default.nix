{
  stdenvNoCC,
  fetchFromGitHub,
  gitUpdater,
  librime,
  rime-data,
}:

stdenvNoCC.mkDerivation rec {
  pname = "rime-shuangping-fuzhuma";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "gaboolic";
    repo = "rime-shuangping-fuzhuma";
    rev = "v${version}";
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
      md \
      bingji \
      readmeimg \
      program \
      LICENSE \
      squirrel.yaml \
      *.trime.yaml

    mkdir -p "$out/share/rime-data"

    cp -r * "$out/share/rime-data"

    runHook postInstall
  '';

  passthru = {
    updateScript = gitUpdater {
      rev-prefix = "v";
    };
  };
}
