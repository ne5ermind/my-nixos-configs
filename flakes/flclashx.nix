{ pkgs }:

pkgs.appimageTools.wrapType2 {
  pname = "flclashx";
  version = "0.3.2";
  src = pkgs.fetchurl {
    url = "https://github.com/pluralplay/FlClashX";
    sha256 = "sha256:7f12e2ee07f203965440af7a3d001ac7c2ddf070529d6702b1346e63c69c4824";
  };
  extraPkgs =
    pkgs: with pkgs; [
      libayatana-appindicator
      gtk3
    ];
}
