{ pkgs }:

pkgs.appimageTools.wrapType2 {
  pname = "flclashx";
  version = "0.3.2";
  src = pkgs.fetchurl {
    url = "https://github.com/pluralplay/FlClashX";
    sha256 = "sha256-iaGKJ8RUyG2HkwzZQMcjWVqyvSGqXQlKTwcuDBa5XsM=";
  };
  extraPkgs =
    pkgs: with pkgs; [
      libayatana-appindicator
      gtk3
    ];
}
