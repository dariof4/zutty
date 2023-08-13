{
  description = "A very basic flake";
  inputs.rust-overlay.url = "github:oxalica/rust-overlay";

  outputs = { self, nixpkgs, rust-overlay }: 
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; overlays = [ (import rust-overlay)]; };
  in
  {

    packages.x86_64-linux.zutty = pkgs.stdenv.mkDerivation {
      pname = "zutty";
      version = "0.14";

      src = ./.;
      nativeBuildInputs = [ pkgs.pkg-config pkgs.wafHook];
      buildInputs = with pkgs; [python3 glib freetype xorg.libXmu libGL];
      wafConfigureFlags = ["--debug"];

    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.zutty;

    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [
      ];
    };

  };
}
