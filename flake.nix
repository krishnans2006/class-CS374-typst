{
  description = "A Nix-flake-based Typst development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = inputs:
  let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
    forEachSupportedSystem = f: inputs.nixpkgs.lib.genAttrs supportedSystems (
      system: f {
        pkgs = import inputs.nixpkgs { inherit system; };
      }
    );
  in
  {
    devShells = forEachSupportedSystem (
      { pkgs }: {
        default = pkgs.mkShellNoCC { packages = with pkgs; [ typst tinymist ]; };
      }
    );
  };
}
