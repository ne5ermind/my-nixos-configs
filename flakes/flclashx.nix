{ pkgs }:

pkgs.appimageTools.wrapType2 {
  pname = "flclashx";
  version = "0.3.2";
  src = pkgs.fetchurl {
    url = "https://github.com/pluralplay/FlClashX/releases/download/v0.3.2/FlClashX-linux-amd64.AppImage";
    sha256 = "sha256:45b2f533a58ab14a31b7cde40e6923a16b36be8201ce9f4fe216d29f9303068c";
  };
  extraPkgs =
    pkgs: with pkgs; [
      libayatana-appindicator
      gtk3
    ];
}
