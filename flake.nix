{
	description = "python dev";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	};

	outputs = { self, nixpkgs }: 
	let
		pkgs = nixpkgs.legacyPackages."x86_64-linux";
	in 
	{
		devShells."x86_64-linux".default = pkgs.mkShell {
			packages = with pkgs; [
				pyright
				poetry
				(python312.withPackages (python-pkgs: with python-pkgs; [
					# jupyter
					# requests
					# beautifulsoup4
					# pandas 
					# openpyxl
					# numpy 
				]))
			];
			inputsFrom = [];
		};
	};
}
