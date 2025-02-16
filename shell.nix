{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
	
    # name (default: nix-shell). Set the name of the derivation.
	# name = "";
  	
    # packages (default: []). Add executable packages to the nix-shell environment.
	packages = with pkgs; [
    lua-language-server
	];

    # inputsFrom (default: []). Add build dependencies of the listed derivations to the nix-shell environment.
	# inputsFrom = [ pkgs.hello ];

    # shellHook (default: ""). Bash statements that are executed by nix-shell.
  	shellHook = ''
    	echo -e "\e[1;33mDevelopment Environment\e[0;32m"
      lua-language-server --version
      echo -e "\e[0m"
  	'';
}
