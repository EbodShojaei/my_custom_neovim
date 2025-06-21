#!/bin/bash

# =============================================================================
# Backup Current Development Environment Configuration
# Author: Ebod Shojaei (Dobes)
# Version: 1.0.0
# =============================================================================

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING: $1${NC}"
}

info() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')] INFO: $1${NC}"
}

# Create backup directory
BACKUP_DIR="./config_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

log "Starting configuration backup to: $BACKUP_DIR"

# =============================================================================
# BACKUP DOTFILES
# =============================================================================

log "Backing up dotfiles..."
mkdir -p "$BACKUP_DIR/dotfiles"

# Copy dotfiles if they exist
dotfiles=(
    ".zshrc"
    ".p10k.zsh"
    ".tmux.conf"
    ".gitconfig"
    ".bash_profile"
    ".bashrc"
    ".vimrc"
)

for file in "${dotfiles[@]}"; do
    if [[ -f "$HOME/$file" ]]; then
        cp "$HOME/$file" "$BACKUP_DIR/dotfiles/"
        info "Backed up: $file"
    else
        warn "File not found: $file"
    fi
done

# =============================================================================
# BACKUP NEOVIM CONFIGURATION
# =============================================================================

log "Backing up Neovim configuration..."
if [[ -d "$HOME/.config/nvim" ]]; then
    cp -r "$HOME/.config/nvim" "$BACKUP_DIR/"
    info "Backed up: Neovim configuration"
else
    warn "Neovim configuration not found"
fi

# =============================================================================
# BACKUP SYSTEM INFORMATION
# =============================================================================

log "Collecting system information..."
mkdir -p "$BACKUP_DIR/system_info"

# System info
{
    echo "=== SYSTEM INFORMATION ==="
    echo "Date: $(date)"
    echo "OS: $(uname -a)"
    echo "Shell: $SHELL"
    echo ""
    
    echo "=== INSTALLED PACKAGES (macOS) ==="
    if command -v brew &> /dev/null; then
        echo "Homebrew packages:"
        brew list --formula
        echo ""
        echo "Homebrew casks:"
        brew list --cask
    else
        echo "Homebrew not found"
    fi
    echo ""
    
    echo "=== INSTALLED FONTS ==="
    if [[ -d "$HOME/Library/Fonts" ]]; then
        ls "$HOME/Library/Fonts" | grep -i nerd || echo "No Nerd Fonts found"
    fi
    echo ""
    
    echo "=== NEOVIM INFORMATION ==="
    if command -v nvim &> /dev/null; then
        nvim --version
    else
        echo "Neovim not found"
    fi
    echo ""
    
    echo "=== ZSH PLUGINS ==="
    if [[ -d "$HOME/.oh-my-zsh/custom/plugins" ]]; then
        ls "$HOME/.oh-my-zsh/custom/plugins"
    else
        echo "Oh My Zsh custom plugins not found"
    fi
    echo ""
    
    echo "=== ENVIRONMENT VARIABLES ==="
    echo "PATH: $PATH"
    echo "EDITOR: $EDITOR"
    echo "VISUAL: $VISUAL"
    
} > "$BACKUP_DIR/system_info/system_info.txt"

# =============================================================================
# CREATE RESTORE INSTRUCTIONS
# =============================================================================

log "Creating restore instructions..."
cat > "$BACKUP_DIR/RESTORE_INSTRUCTIONS.md" << 'EOF'
# Restore Instructions

This backup contains your development environment configuration from macOS.

## Files Included:
- `dotfiles/` - Your shell and application configuration files
- `nvim/` - Your Neovim configuration
- `system_info/` - Information about your system and installed packages

## To Restore on a New System:

### Option 1: Use the Ubuntu Setup Script
1. Run the `ubuntu_setup.sh` script first
2. Then manually copy specific customizations from the `dotfiles/` directory

### Option 2: Manual Restore
1. Copy dotfiles to your home directory:
   ```bash
   cp dotfiles/.zshrc ~/
   cp dotfiles/.p10k.zsh ~/
   cp dotfiles/.tmux.conf ~/
   cp dotfiles/.gitconfig ~/
   ```

2. Copy Neovim configuration:
   ```bash
   mkdir -p ~/.config
   cp -r nvim ~/.config/
   ```

3. Install required dependencies (see `system_info/system_info.txt`)

## Notes:
- Make sure to install Nerd Fonts before using the configurations
- Update paths and system-specific settings as needed
- Run `p10k configure` to set up your prompt after restore
EOF

# =============================================================================
# SUMMARY
# =============================================================================

log "✅ Configuration backup completed successfully!"
echo ""
info "Backup location: $BACKUP_DIR"
info "Backup includes:"
echo "  • Dotfiles (.zshrc, .p10k.zsh, .tmux.conf, etc.)"
echo "  • Neovim configuration"
echo "  • System information and package lists"
echo "  • Restore instructions"
echo ""
warn "To use this backup:"
echo "  1. Copy the backup to your new system"
echo "  2. Run the ubuntu_setup.sh script"
echo "  3. Follow the restore instructions in RESTORE_INSTRUCTIONS.md"
echo ""
log "Backup ready for deployment! 🚀" 