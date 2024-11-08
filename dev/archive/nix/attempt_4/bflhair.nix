{ pkgs, lib, ... }:

{
  # Machine-specific Darwin configuration
  networking = {
    computerName = "bflhair";
    hostName = "bflhair";
    localHostName = "bflhair";
  };

  # Machine-specific home-manager configuration
  home-manager.users."lucho.hristov" = { pkgs, lib, ... }: {
    # Add work machine specific packages here
    home.packages = with pkgs; [ ollama ];

    # Machine-specific VSCode extensions (if needed)
    programs.vscode = {
      userSettings = {
        "aws.telemetry" = false;
        "sqltools.dependencyManager" = {
          "packageManager" = "npm";
          "installArgs" = [ "install" ];
          "runScriptArgs" = [ "run" ];
          "autoAccept" = false;
        };
        "sqltools.useNodeRuntime" = true;
        "window.zoomLevel" = 1;
        "redhat.telemetry.enabled" = false;
        "markdown-pdf.executablePath" = "/Applications/Google Chrome.app";
        "files.associations" = { "*.py" = "python"; };
        "[typescript]" = { };
        "[nix]" = { "editor.defaultFormatter" = "brettm12345.nixfmt-vscode"; };
        "github.copilot.editor.enableAutoCompletions" = false;
        "dev.containers.dockerPath" =
          "/etc/profiles/per-user/lucho.hristov/bin/docker";
        "direnv.path.executable" =
          "/etc/profiles/per-user/lucho.hristov/bin/direnv";
        "css.enabledLanguages" = "nunjucks html";
        "amazonQ" = {
          "shareContentWithAWS" = false;
          "telemetry" = false;
        };
        "continue.enableTabAutocomplete" = false;
      };
      extensions = with pkgs.vscode-extensions;
        [
          # Add any bflhair-specific VSCode extensions here
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # Add any marketplace extensions here if needed
        ];
    };

    # Add any work machine specific configurations here
    programs.git.extraConfig = {
      user.email = lib.mkForce "lucho@blankfactor.com";
    };
  };

  # Machine-specific Homebrew configuration
  homebrew.casks = [
    # Add work machine specific casks here
  ];

  homebrew.brews = [
    # Add work machine specific brews here
  ];
}
