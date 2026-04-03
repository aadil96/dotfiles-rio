# Local machine-specific zsh configuration
# This file is excluded from version control and should be manually maintained

# Windows/WSL paths (Aadil's local machine)
export WIN_DLS="/mnt/c/Users/agwan/Downloads/"

# Enable Windows access for Vagrant in WSL
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"

# Add VirtualBox to PATH only if not already present
if [[ ":$PATH:" != *":/mnt/c/Program Files/Oracle/VirtualBox:"* ]]; then
  export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
fi