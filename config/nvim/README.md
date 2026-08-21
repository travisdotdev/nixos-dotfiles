# Nvim config

Built on **Neovim 0.12+** with native vim.pack plugin management.

Requirements

Neovim 0.12+
WSL2 (Ubuntu) on Windows
Nerd Font (for glyphs, icons etc.)

![dashboard](assets/nvim_dashboard.png)

## Setup (UBUNTU via WSL)

### 1. I use WSL for now

    wsl --install -d Ubuntu

 ### 2. Neovim 0.12+

    The apt version is too old. Install the latest release:

    bashcurl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc
    source ~/.bashrc

### 3. Dependencies

    sudo apt update
    sudo apt install -y build-essential unzip ripgrep fd-find nodejs npm python3-pip python3-venv
    npm install -g tree-sitter-cli

### 4. Config

    git clone https://github.com/travisdotdev/nvim-config.git ~/.config/nvim

### 5. First launch

    run in terminal: nvim

    On first launch, vim.pack downloads all plugins 
    approve the prompt, then restart Neovim. 
    Mason installs the language servers (pyright, lua_ls, clangd, debugpy) automatically 
    add or remove whatever lsps/debuggers you need.

    Run :checkhealth to verify the setup.

    keymaps are in keymap.lua
![dashboard](assets/example_workflow.png)
