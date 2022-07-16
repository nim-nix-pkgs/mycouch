{
  description = ''a couchDB client written in Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-mycouch-main.flake = false;
  inputs.src-mycouch-main.ref   = "refs/heads/main";
  inputs.src-mycouch-main.owner = "hamidb80";
  inputs.src-mycouch-main.repo  = "mycouch";
  inputs.src-mycouch-main.type  = "github";
  
  inputs."macroutils".owner = "nim-nix-pkgs";
  inputs."macroutils".ref   = "master";
  inputs."macroutils".repo  = "macroutils";
  inputs."macroutils".dir   = "v1_2_0";
  inputs."macroutils".type  = "github";
  inputs."macroutils".inputs.nixpkgs.follows = "nixpkgs";
  inputs."macroutils".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."macroplus".owner = "nim-nix-pkgs";
  inputs."macroplus".ref   = "master";
  inputs."macroplus".repo  = "macroplus";
  inputs."macroplus".dir   = "0_2_3";
  inputs."macroplus".type  = "github";
  inputs."macroplus".inputs.nixpkgs.follows = "nixpkgs";
  inputs."macroplus".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/hamidb80/coverage".owner = "nim-nix-pkgs";
  inputs."github.com/hamidb80/coverage".ref   = "master";
  inputs."github.com/hamidb80/coverage".repo  = "github.com/hamidb80/coverage";
  inputs."github.com/hamidb80/coverage".dir   = "";
  inputs."github.com/hamidb80/coverage".type  = "github";
  inputs."github.com/hamidb80/coverage".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/hamidb80/coverage".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-mycouch-main"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-mycouch-main";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}