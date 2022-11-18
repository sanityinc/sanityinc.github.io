{
  description = "Sanityinc.com";

  inputs =
    {
      nixpkgs.url = "nixpkgs/nixpkgs-unstable";
      flake-utils.url = "github:numtide/flake-utils";
    };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { localSystem = system; };
        app = (pkgs.callPackage ./. { });
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [ app.ruby pkgs.bundix app ];
        };
      }
    );
}
