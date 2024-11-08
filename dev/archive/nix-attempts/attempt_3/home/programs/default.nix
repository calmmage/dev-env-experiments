{ config, pkgs, ... }: {
  programs = {
    git = {
      enable = true;
      userName = "Petr Lavrov";
      userEmail = "petr.b.lavrov@gmail.com";
    };
    
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
    };
  };
} 