{
  description = "A starting point for your devshell";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable"; # unstable (rolling release) channel
  # inputs.nixpkgs.url = "nixpkgs/nixos-23.11"; # stable channel (FIXME: stables are *.04 and *.11, make sure you are using the latest)

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          inherit system;
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    # Nix code formatter; I like alejandra, but nixpkgsfmt, nixfmt-classic, and nixfmt-rfc-style also exist
    formatter = forEachSupportedSystem ({pkgs, ...}: pkgs.alejandra);

    # Packages exported by this flake
    packages = forEachSupportedSystem ({...}: {});

    devShells = forEachSupportedSystem ({pkgs, ...}: {
      default = pkgs.mkShell {
        # Here you can put the dev dependencies
        # packages = with pkgs; [pkg-config];

        # You can also define environment valiables to export
        # API_KEY = "hello_world";

        # And shell code to run when starting the environment
        # shellHook = "echo 'Connecting to dev db...'";
      };
    });
  };
}
