{ nixpkgs ? import <nixpkgs> {} , compiler ? "ghc865" }:
let
  inherit (nixpkgs) haskellPackages;
   myPackages = import ./release.nix {inherit nixpkgs compiler; };

  bootstrap = import <nixpkgs> { };

  nixpgs-19-03 = builtins.fromJSON (builtins.readFile ./nixpkgs-18-09.json);

  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (nixpgs-19-03) rev sha256;
  };

  pinnedPkgs = import src { };
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in
  haskellPackages.shellFor {
    withHoogle = true;
    packages = p: [myPackages];
    buildInputs =  
     [ nixpkgs.haskellPackages.hlint 
       nixpkgs.haskellPackages.stylish-haskell
       nixpkgs.haskellPackages.hoogle
       pinnedPkgs.cabal-install
       (all-hies.selection {selector = p: {inherit (p) ghc865; };}) 
     ];
}
