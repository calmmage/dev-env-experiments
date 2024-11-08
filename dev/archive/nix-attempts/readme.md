This is a folder for all nix-related files

# Step 1

```bash
nix flake init -t nix-darwin
sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix
```

# Step 2
Move the system configuration from flake.nix to darwin.nix:

1. Create a new file called `darwin.nix`
2. Move the system configuration into `darwin.nix`
3. Update `flake.nix` to import the configuration from `darwin.nix`

After this setup, you can build your configuration with:
```bash
darwin-rebuild switch --flake .
```
