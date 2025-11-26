{
  fetchFromGitHub,
  stdenv,
  librime,
  rime-data,
}:

stdenv.mkDerivation {
  pname = "rime-shuangpin-fuzhuma";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "gaboolic";
    repo = "rime-shuangpin-fuzhuma";
    tag = "1.0.3";
    sha256 = "sha256-Dz+jAa46iU4/gXVpDTzQRzzQfl97knGGON7Kmq4v/3M=";
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

    dst=$out/share/rime-data
    mkdir -p $dst

    rm -r .github md bingji readmeimg program LICENSE squirrel.yaml *.trime.yaml

    cp -pr -t $dst *

    runHook postInstall
  '';
}
