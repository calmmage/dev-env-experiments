# Setup from scratch

Follow this YouTube video:

[Walkthrough of Nix Install and Setup on MacOS](https://www.youtube.com/watch?v=LE5JR4JcvMg&t=2773s)

...

Install Nix

Install nix-darwin

`darwin-rebuild switch --flake ~/src/system-config/.#`

Cachix

nix profile install nixpkgs#cachix

echo "echo "trusted-users = root $USER"" | sudo tee -a /etc/nix/nix.conf && sudo pkill nix-daemon

cachix use devenv

After the above runs successfully, use the alias `nixswitch` instead.
