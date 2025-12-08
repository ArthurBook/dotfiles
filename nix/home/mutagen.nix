{ config, lib, pkgs, ... }:

{
  home.file.".mutagen.yml".text = ''
    sync:
      defaults:
        mode: one-way-safe
        maxStagingFileSize: 1 MB
        ignore:
          vcs: true # .git subdir
          paths:
            - "!.lock"
            - ".env"
            - ".*cache"
            - ".venv" # python venv
            - "output" # mostly for idle/data
            - "logs" # logs venv
  '';
}
