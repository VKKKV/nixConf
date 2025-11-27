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
    sha256 = "sha256-1139fJBfqe3KFdDZhiS34CAevXeqPdcYaMqb3drXZSY=";
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
