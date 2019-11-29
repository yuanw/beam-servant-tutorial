{ nixpkgs ? import <nixpkgs> {} , compiler ? "ghc865" }:
let
  inherit (nixpkgs) haskellPackages;
  myPackages = haskellPackages.callCabal2nix "project" ./beam-servant-tutorial.cabal  {};

  bootstrap = import <nixpkgs> { };

  nixpgs-19-03-beta = builtins.fromJSON (builtins.readFile ./nixpkgs-19-03-beta.json);

  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (nixpgs-19-03-beta) rev sha256;
  };

  pinnedPkgs = import src { };
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in
  haskellPackages.shellFor {
    withHoogle = true;
    packages = p: [myPackages];
    buildInputs = with nixpkgs.haskellPackages;
      [ hlint
        ghcid
        stylish-haskell
        ormolu
        hoogle
        (all-hies.selection {selector = p: {inherit (p) ghc865; };})
     ] ++ [pinnedPkgs.cabal-install];
}
