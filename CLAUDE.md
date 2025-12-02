# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This is a comprehensive Nix-based dotfiles repository for macOS using nix-darwin and home-manager. This guide provides Claude Code instances with the essential architecture understanding and commands needed to work effectively with this codebase.

## Development Guidelines

### Research and Documentation
- **ALWAYS** use WebSearch to find and read current documentation for Nix, nix-darwin, home-manager, and any other dependencies before making changes
- Check official documentation, release notes, and best practices guides for the specific versions in use
- When updating dependencies, research breaking changes and migration guides first

### Configuration Philosophy
- **Keep configurations maximally simple** on the first pass
- Start with minimal, working configurations using defaults wherever possible
- Only add advanced features, customizations, or optimizations when explicitly requested
- Prefer built-in options over custom implementations

### Best Practices
- Follow all Nix ecosystem best practices for:
  - Flake structure and input management
  - Module organization and imports
  - Package selection and configuration
  - Secret management with SOPS
- Use official NixOS/nixpkgs options whenever available
- Maintain clear separation between system and user configurations
- Test configurations with `nix flake check` before applying

### Repository Maintenance
- **Always update the CLAUDE.md file structure map** when adding, removing, or moving files
- Keep the Core Structure section current to reflect the actual repository layout
- Update file descriptions when their purposes change

## Repository Architecture Overview

### Core Structure
```
dotfiles/
├── flake.nix                    # Main flake configuration with inputs/outputs
├── nix/
│   ├── system/darwin.nix        # nix-darwin system-level configuration
│   ├── home/                    # home-manager user-level configurations
│   │   ├── common.nix          # Main home-manager entry point
│   │   ├── packages/           # Package configurations
│   │   │   ├── default.nix     # Simple packages without config
│   │   │   ├── bat.nix         # Bat (cat replacement) with Tokyo Night theme
│   │   │   ├── bottom.nix      # System monitor with custom config
│   │   │   ├── direnv.nix      # Environment manager with Python support
│   │   │   └── eza.nix         # Modern ls with Tokyo Night theme
│   │   ├── secrets.nix         # SOPS secret management
│   │   ├── git.nix            # Git configuration
│   │   ├── editor/            # Editor configurations
│   │   │   ├── neovim.nix     # Comprehensive Neovim setup
│   │   │   └── tools.nix      # Editor tooling
│   │   └── shell/             # Shell configurations
│   │       ├── fish.nix       # Fish shell with Vi bindings
│   │       ├── starship.nix   # Prompt configuration
│   │       └── zellij.nix     # Terminal multiplexer
│   └── hosts/
│       └── macbook.nix         # Host-specific configuration
├── secrets/                     # SOPS-encrypted secrets
│   ├── secrets.yaml            # Encrypted secrets file
│   └── README.md               # Secret management instructions
└── static/                     # Static assets
```

### Dual Configuration System

This repository uses a **dual configuration approach**:

1. **nix-darwin** (`darwinConfigurations."workbook"`) - System-level configuration
   - Managed in `/nix/system/darwin.nix`
   - Handles system packages (tailscale, mosh), Homebrew casks (Docker Desktop), services, and system settings
   - Homebrew integration with automatic cleanup and package management
   - Enables experimental Nix features and configures the Nix daemon

2. **home-manager** (`homeConfigurations."macos"`) - User-level configuration
   - Managed in `/nix/home/` directory structure
   - Handles user packages, dotfiles, and application configurations
   - Modular design with separate files for different concerns

### Key Architectural Decisions

#### Modular Configuration Structure
- **Separation of concerns**: Each tool/application has its own configuration file
- **Composable modules**: The `common.nix` imports all other home modules
- **Host-specific overrides**: Host configurations can override common settings

#### Secret Management with SOPS
- Uses `sops-nix` for encrypting sensitive configurations
- Age encryption with keys stored in `~/.config/sops/age/keys.txt`
- Secrets are referenced in configurations but decrypted at activation time
- Git and SSH configurations use secrets for sensitive data

#### Theme Consistency
- **Tokyo Night** theme applied consistently across all tools
- Custom color configurations for terminals, editors, and CLI tools
- Transparency and visual consistency maintained throughout

## Essential Commands

### Initial Setup
```bash
# Clone repository
DOTFILES_LOC=~/projects/dotfiles
git clone git@github.com:ArthurBook/dotfiles.git ${DOTFILES_LOC}
cd ${DOTFILES_LOC}

# Initial system setup (includes both nix-darwin and home-manager)
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .
```

### Daily Usage
```bash
# Rebuild entire system (both system and user configurations)
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .

# Test configuration without switching
sudo nix run nix-darwin#darwin-rebuild -- build --flake .

# Home-manager only rebuild (for testing user changes)
nix run home-manager#home-manager -- switch --flake .

# Update flake inputs
nix flake update

# Check what would be updated
nix flake check
```

### Secret Management
```bash
# Edit secrets (requires sops and age keys)
sops secrets/secrets.yaml

# Decrypt secrets for viewing (read-only)
sops --decrypt secrets/secrets.yaml
```

### Development Workflow
```bash
# Format Nix files
nix fmt

# Check flake for issues
nix flake check

# Show flake info
nix flake show

# Build specific configuration without switching
nix build .#darwinConfigurations.workbook.system
nix build .#homeConfigurations.macos.activationPackage
```

## Key Configuration Files

### Critical Files to Understand

1. **`/Users/arthurbook/projects/dotfiles/flake.nix`**
   - Defines inputs (nixpkgs, nix-darwin, home-manager, sops-nix)
   - Two separate outputs: darwinConfigurations and homeConfigurations
   - Uses nixpkgs-25.05-darwin and release-25.05 branches

2. **`/Users/arthurbook/projects/dotfiles/nix/system/darwin.nix`**
   - System-level packages: tailscale, mosh
   - Homebrew integration with auto-cleanup and Docker Desktop cask
   - Enables experimental features and configures Nix daemon
   - Configures system services (tailscale daemon)

3. **`/Users/arthurbook/projects/dotfiles/nix/home/common.nix`**
   - Central import point for all home-manager modules
   - Enables font installation and sets home state version

4. **`/Users/arthurbook/projects/dotfiles/nix/home/packages/`**
   - `default.nix`: Simple packages without configuration (dust, fd, ripgrep, uv, etc.)
   - Individual files for packages with configuration (bat.nix, bottom.nix, direnv.nix, eza.nix)
   - Tokyo Night theming consistently applied across configured tools

5. **`/Users/arthurbook/projects/dotfiles/nix/home/secrets.nix`**
   - SOPS configuration pointing to age keys and secrets.yaml
   - Git and SSH configuration integration with secrets

### Shell Environment

- **Fish shell** with Vi key bindings and custom navigation shortcuts
- **Starship** prompt for consistent terminal experience
- **Zellij** terminal multiplexer auto-starts in interactive shells
- **Direnv** for automatic environment loading with uv support

### Editor Configuration

- **Neovim** with comprehensive plugin setup via Lazy.nvim
- LSP support for Python (pyright, ruff), with completion and diagnostics
- Tokyo Night theme with transparency throughout
- Modern plugin ecosystem: telescope, neo-tree, which-key, flash.nvim

## Common Modification Patterns

### Adding New Packages
- **Simple packages**: Add to `/Users/arthurbook/projects/dotfiles/nix/home/packages/default.nix` in the `home.packages` list
- **Packages with configuration**: Create a new file `/Users/arthurbook/projects/dotfiles/nix/home/packages/[package-name].nix` and import it in `default.nix`

### Adding New Applications
Create a new module in `/Users/arthurbook/projects/dotfiles/nix/home/` and import it in `common.nix`.

### Host-Specific Changes
Modify `/Users/arthurbook/projects/dotfiles/nix/hosts/macbook.nix` for machine-specific configurations.

### System-Level Changes
Edit `/Users/arthurbook/projects/dotfiles/nix/system/darwin.nix` for system packages and services.

### Secret Management
Use `sops secrets/secrets.yaml` to edit encrypted secrets, then reference them in configurations.

## Troubleshooting

### Common Issues
- **Build failures**: Check with `nix flake check` first
- **Secret access**: Ensure age keys exist at `~/.config/sops/age/keys.txt`
- **Permission issues**: System changes require `sudo`, user changes don't
- **Path issues**: Fish shell initialization handles Nix path setup

### Debugging Commands
```bash
# Verbose rebuild output
sudo nix run nix-darwin#darwin-rebuild -- switch --flake . --show-trace

# Check current generation
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback system
sudo nix-env --rollback --profile /nix/var/nix/profiles/system
```

This architecture provides a robust, reproducible development environment with careful separation between system and user concerns, comprehensive secret management, and consistent theming throughout.
