let
  pkgs = import ./pkgs.nix;
  app = (pkgs.callPackage ./. { });
in
pkgs.mkShell {
  # https://github.com/NixOS/nixpkgs/pull/61114
  # https://github.com/NixOS/nixpkgs/pull/61684
  # https://github.com/NixOS/nixpkgs/pull/51842
  # https://github.com/NixOS/nixpkgs/issues/54303
  buildInputs = [
    app.ruby
    pkgs.bundix
    app
  ];
}
