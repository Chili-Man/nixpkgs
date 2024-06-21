{
  lib,
  stdenv,
  altair,
  blinker,
  buildPythonPackage,
  cachetools,
  click,
  fetchPypi,
  gitpython,
  importlib-metadata,
  numpy,
  packaging,
  pandas,
  pillow,
  protobuf,
  pyarrow,
  pydeck,
  pympler,
  python-dateutil,
  pythonOlder,
  pythonRelaxDepsHook,
  setuptools,
  requests,
  rich,
  tenacity,
  toml,
  tornado,
  typing-extensions,
  tzlocal,
  validators,
  watchdog,
}:

buildPythonPackage rec {
  pname = "streamlit";
  version = "1.36.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-oSr58Othq1gy9DgzYlex7CDrKdjg4Ma0CnkRa6k5vJw=";
  };

  nativeBuildInputs = [
    setuptools
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [ "packaging" ];

  propagatedBuildInputs = [
    altair
    blinker
    cachetools
    click
    gitpython
    importlib-metadata
    numpy
    packaging
    pandas
    pillow
    protobuf
    pyarrow
    pydeck
    pympler
    python-dateutil
    requests
    rich
    tenacity
    toml
    tornado
    typing-extensions
    tzlocal
    validators
  ] ++ lib.optionals (!stdenv.isDarwin) [ watchdog ];

  # pypi package does not include the tests, but cannot be built with fetchFromGitHub
  doCheck = false;

  pythonImportsCheck = [ "streamlit" ];

  postInstall = ''
    rm $out/bin/streamlit.cmd # remove windows helper
  '';

  meta = with lib; {
    homepage = "https://streamlit.io/";
    changelog = "https://github.com/streamlit/streamlit/releases/tag/${version}";
    description = "Fastest way to build custom ML tools";
    mainProgram = "streamlit";
    maintainers = with maintainers; [
      natsukium
      yrashk
    ];
    license = licenses.asl20;
  };
}
