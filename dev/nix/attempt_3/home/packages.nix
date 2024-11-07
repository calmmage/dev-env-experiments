{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Development
    git
    gh
    
    # CLI tools
    ripgrep
    fd
    jq
    
    # Additional tools can be added here
  ];
} 