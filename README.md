# nvim lua setup

## preperation

First, install nvim and remove/ backup the config files:

```sh
cd ~/bin && \
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage --output nvim && \
chmod u+x nvim
```

```sh
mv ~/.config/nvim ~/.config/nvim.bak && \
mv ~/.local/share/nvim ~/.local/share/nvim.bak && \
mv ~/.local/state/nvim ~/.local/state/nvim.bak
```

Then open a terminal and clone packer:

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Next install a compiler-driver for the amazing nvim tree-sitter:

```sh
sudo apt update && sudo apt install g++ -y
```

Finally install BurntSushi's `ripgrep` for telescope's grep search:

```sh
sudo apt update && sudo apt install ripgrep
```

## install plugins

Start nvim:

```sh
nvim
```

and run `:PackerSync`

