{ config, lib, ... }:

{
  # SOPS configuration
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = {
      "gitconfig" = { key = "gitconfig"; };
      "sshconfig" = { key = "sshconfig"; };
    };
  };

  # Git config using secrets - include the gitconfig section directly
  programs.git = {
    includes = [
      {
        path = config.sops.secrets.gitconfig.path;
      }
    ];
  };

  # SSH config using secrets - include the ssh config via SSH's Include directive
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Include ${config.sops.secrets.sshconfig.path}
    '';
  };
}
