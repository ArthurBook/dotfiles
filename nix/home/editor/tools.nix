{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code # Agentic coding tool that lives in your terminal
    lazygit # A simple terminal UI for git commands
    pyright # Python LSP
  ];

  # Lazygit configuration
  home.file.".config/lazygit/config.yml".text = ''
    promptToReturnFromSubprocess: false
    git:
      paging:
        colorArg: always
    os:
      editCommand: 'nvim'
      editCommandTemplate: '{{editor}} {{filename}}'
      editInTerminal: true
      suspend: false
    gui:
      returnImmediately: true
  '';
}