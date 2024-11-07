Workalong 1

Plan the next steps
Not steps - directions
- d1: write a shell script that will install all the basic stuff
- d2: try to follow some guide (zero to nix or somthing)
- d3: try using basic nix setup to get at least some things done


----

# Step 1 - install nix

## Options

Option 1: Official installer
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Option 2: 'Determinate installer'
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## Choice

I went with Determinate installer


# Step 2 - enable nix-darwin

## Options
Option 1: Install with nix-build
https://github.com/LnL7/nix-darwin?tab=readme-ov-file#installing
```bash
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```

Option 2:
```bash
nix flake init -t nix-darwin
sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix
```

## Choice

I went with Option 2

Also, I've 