#!/bin/bash

# =============================================================================
# Ubuntu Development Environment Setup Script
# Author: Ebod Shojaei (Dobes)
# Version: 1.0.0
# =============================================================================

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING: $1${NC}"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}"
}

info() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')] INFO: $1${NC}"
}

# Check if running on Ubuntu
if [[ ! -f /etc/os-release ]] || ! grep -q "ubuntu" /etc/os-release; then
    error "This script is designed for Ubuntu systems only."
    exit 1
fi

log "Starting Ubuntu development environment setup..."

# =============================================================================
# SYSTEM UPDATE AND BASIC PACKAGES
# =============================================================================

log "Updating system packages..."
sudo apt update && sudo apt upgrade -y

log "Installing essential packages..."
sudo apt install -y \
    curl \
    wget \
    git \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    unzip \
    fontconfig \
    python3 \
    python3-pip \
    nodejs \
    npm \
    ripgrep \
    fd-find \
    tmux \
    tree \
    htop \
    neofetch \
    zsh

# =============================================================================
# INSTALL NEOVIM (LATEST VERSION)
# =============================================================================

log "Installing Neovim (latest stable)..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz

# =============================================================================
# INSTALL NERD FONTS
# =============================================================================

log "Installing Nerd Fonts..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# Download and install popular Nerd Fonts
fonts=(
    "JetBrainsMono"
    "FiraCode" 
    "Hack"
    "Meslo"
)

for font in "${fonts[@]}"; do
    info "Installing $font Nerd Font..."
    wget -P /tmp "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/${font}.zip"
    unzip -o "/tmp/${font}.zip" -d "$FONT_DIR"
    rm "/tmp/${font}.zip"
done

# Update font cache
fc-cache -fv

# =============================================================================
# INSTALL OH-MY-ZSH AND POWERLEVEL10K
# =============================================================================

log "Installing Oh My Zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

log "Installing Powerlevel10k theme..."
if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

# =============================================================================
# INSTALL ZSH PLUGINS
# =============================================================================

log "Installing zsh plugins..."

# zsh-autosuggestions
if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# =============================================================================
# SETUP DOTFILES
# =============================================================================

log "Setting up dotfiles..."

# Backup existing dotfiles
backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir"

for file in .zshrc .p10k.zsh .tmux.conf .gitconfig; do
    if [[ -f "$HOME/$file" ]]; then
        warn "Backing up existing $file to $backup_dir"
        mv "$HOME/$file" "$backup_dir/"
    fi
done

# Clone or update the neovim config repository
REPO_DIR="$HOME/.config/dobes-dev-env"
if [[ -d "$REPO_DIR" ]]; then
    log "Updating existing repository..."
    cd "$REPO_DIR" && git pull
else
    log "Cloning development environment repository..."
    git clone https://github.com/EbodShojaei/my_custom_neovim.git "$REPO_DIR"
fi

# =============================================================================
# SETUP NEOVIM CONFIGURATION
# =============================================================================

log "Setting up Neovim configuration..."
mkdir -p "$HOME/.config"

# Remove existing nvim config if it exists
if [[ -d "$HOME/.config/nvim" ]]; then
    warn "Backing up existing Neovim config..."
    mv "$HOME/.config/nvim" "$backup_dir/nvim_backup"
fi

# Link the nvim configuration
if [[ -d "$REPO_DIR/nvim" ]]; then
    ln -sf "$REPO_DIR/nvim" "$HOME/.config/nvim"
    log "Neovim configuration linked successfully"
else
    error "Neovim configuration not found in repository"
fi

# =============================================================================
# SETUP SHELL CONFIGURATIONS
# =============================================================================

log "Setting up shell configurations..."

# Create .zshrc
cat > "$HOME/.zshrc" << 'EOF'
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    colored-man-pages
    command-not-found
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'
export VISUAL='nvim'

# Aliases
alias vim='nvim'
alias vi='nvim'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Custom PATH
export PATH="$HOME/.local/bin:$PATH"

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

# Setup p10k configuration (basic setup - user can reconfigure later)
if [[ -f "$REPO_DIR/dotfiles/.p10k.zsh" ]]; then
    cp "$REPO_DIR/dotfiles/.p10k.zsh" "$HOME/.p10k.zsh"
else
    # Create a basic p10k config
    log "Creating basic p10k configuration..."
    cat > "$HOME/.p10k.zsh" << 'EOF'
# Basic Powerlevel10k configuration
# Run 'p10k configure' to customize
'use strict'
() {
  emulate -L zsh -o extended_glob
  unset POWERLEVEL9K_*
  autoload -U is-at-least && is-at-least 5.1 || return
  
  # The list of segments shown on the left. Fill it with the most important segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    dir                     # current directory
    vcs                     # git status
    prompt_char             # prompt symbol
  )
  
  # The list of segments shown on the right. Fill it with less important segments.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # exit code of the last command
    command_execution_time  # duration of the last command
    background_jobs         # presence of background jobs
    time                    # current time
  )
  
  # Basic styling
  typeset -g POWERLEVEL9K_MODE=nerdfont-v3
  typeset -g POWERLEVEL9K_ICON_PADDING=moderate
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=''
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='❯ '
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX=''
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX=''
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX=''
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''
  typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_FIRST_SEGMENT_END_SYMBOL='%{%}'
  typeset -g POWERLEVEL9K_EMPTY_LINE_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='%{%}'
}
EOF
fi

# Setup tmux configuration
if [[ -f "$REPO_DIR/dotfiles/.tmux.conf" ]]; then
    cp "$REPO_DIR/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
else
    log "Creating basic tmux configuration..."
    cat > "$HOME/.tmux.conf" << 'EOF'
# Basic tmux configuration
set -g default-terminal "screen-256color"
set -g prefix C-a
unbind C-b
bind-key C-a send-prefix

# Split panes
bind | split-window -h
bind - split-window -v

# Switch panes
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Enable mouse mode
set -g mouse on

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1
EOF
fi

# Setup git configuration (basic)
if [[ ! -f "$HOME/.gitconfig" ]]; then
    log "Setting up basic git configuration..."
    cat > "$HOME/.gitconfig" << 'EOF'
[user]
    name = Your Name
    email = your.email@example.com
[core]
    editor = nvim
[init]
    defaultBranch = main
[pull]
    rebase = false
EOF
    warn "Please update your git configuration with: git config --global user.name 'Your Name' && git config --global user.email 'your.email@example.com'"
fi

# =============================================================================
# FINAL SETUP
# =============================================================================

log "Changing default shell to zsh..."
if [[ "$SHELL" != "$(which zsh)" ]]; then
    chsh -s $(which zsh)
    log "Default shell changed to zsh. Please log out and log back in for the change to take effect."
fi

log "Installing Neovim plugins (this may take a moment)..."
nvim --headless "+Lazy! sync" +qa 2>/dev/null || warn "Neovim plugin installation may have encountered issues. Run ':Lazy sync' in Neovim to retry."

# =============================================================================
# COMPLETION MESSAGE
# =============================================================================

log "🎉 Ubuntu development environment setup completed successfully!"
echo ""
info "What was installed:"
echo "  ✅ Neovim (latest) with your custom configuration"
echo "  ✅ Oh My Zsh with Powerlevel10k theme"
echo "  ✅ Nerd Fonts (JetBrainsMono, FiraCode, Hack, Meslo)"
echo "  ✅ Essential development tools"
echo "  ✅ Tmux with basic configuration"
echo "  ✅ Zsh plugins (autosuggestions, syntax highlighting)"
echo ""
warn "Next steps:"
echo "  1. Log out and log back in (or restart terminal) to activate zsh"
echo "  2. Set your terminal font to a Nerd Font (e.g., 'JetBrainsMono Nerd Font')"
echo "  3. Run 'p10k configure' to customize your prompt"
echo "  4. Update git config: git config --global user.name 'Your Name'"
echo "  5. Update git config: git config --global user.email 'your.email@example.com'"
echo ""
if [[ -n "$backup_dir" ]]; then
    info "Your original dotfiles are backed up in: $backup_dir"
fi

log "Enjoy your new development environment! 🚀" 