{
  description = "Sanityinc.com";

  inputs =
    {
      nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
    in
    {
      devShell = forAllSystems
        (system:
          let
            pkgs = import nixpkgs { localSystem = system; };
            app = (pkgs.callPackage ./. { });
          in
          pkgs.mkShell {
            buildInputs = [ app.ruby pkgs.bundix app ];
          }
        );
    };
}
