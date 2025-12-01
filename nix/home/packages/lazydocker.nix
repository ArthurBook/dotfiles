{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    lazydocker
  ];
  home.file.".config/lazydocker/config.yml".text = ''
    gui:
      scrollHeight: 2
      language: 'en'
      theme:
        activeBorderColor:
          - '#7aa2f7' # Tokyo Night blue
        inactiveBorderColor:
          - '#414868' # Tokyo Night comment
        optionsTextColor:
          - '#c0caf5' # Tokyo Night foreground
        selectedLineBgColor:
          - '#283457' # Tokyo Night selection
        selectedRangeBgColor:
          - '#283457'
      returnImmediately: false
      wrapMainPanel: true
    logs:
      timestamps: false
      since: '60m'
      tail: '200'
    commandTemplates:
      dockerCompose: docker-compose
      restartService: '{{ .DockerCompose }} restart {{ .Service.Name }}'
      upService: '{{ .DockerCompose }} up -d {{ .Service.Name }}'
      downService: '{{ .DockerCompose }} stop {{ .Service.Name }}'
      serviceTop: '{{ .DockerCompose }} top {{ .Service.Name }}'
    confirmOnQuit: false
    stats:
      graphs:
        - caption: CPU (%)
          statPath: DerivedStats.CPUPercentage
          color: '#7aa2f7'
        - caption: Memory (%)
          statPath: DerivedStats.MemoryPercentage
          color: '#f7768e'
  '';
}
