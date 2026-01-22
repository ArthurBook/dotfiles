{ config, pkgs, pkgsUnstable, ... }:

{
  home.packages = with pkgs; [
    pkgsUnstable.claude-code # Agentic coding tool that lives in your terminal
    pkgsUnstable.gemini-cli # Agentic coding tool that lives in your terminal
    pkgsUnstable.codex # Agentic coding tool that lives in your terminal
    pkgs.lazygit # A simple terminal UI for git commands
    pkgs.pyright # Python LSP
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
