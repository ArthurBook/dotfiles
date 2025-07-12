#!/bin/bash

setup_os() {
  case $(uname -s) in
  Darwin*)
    setup_macos
    ;;
  Linux*)
    setup_linux
    ;;
  *)
    echo "Unsupported OS" && exit 1
    ;;
  esac
}

setup_macos() {
  install_homebrew
  brew bundle --file=~/.config/brew/Brewfile
  ansible-playbook -i ~/.bootstrap/inventory.yml ~/.bootstrap/setup_macos.yml --ask-become-pass
}

install_homebrew() {
  if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew is already installed. Skipping installation."
  fi
}

setup_linux() {
  if [ -f /etc/lsb-release ]; then
    setup_ubuntu
  else
    echo "Unsupported Linux distribution"
    exit 1
  fi
}

setup_ubuntu() {
  sudo apt-get update
  sudo apt-get install -y ansible
  ansible-playbook -i ~/.bootstrap/inventory.yml ~/.bootstrap/setup_ubuntu.yml --ask-become-pass
}

setup_os
echo "Ansible installation complete."
