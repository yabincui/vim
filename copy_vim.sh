#!/bin/bash

rm -rf ~/.vimrc ~/.vim
cp .vimrc ~
cp .vim ~ -r
gvim ~/.vimrc
echo "Run :PluginInstall in gvim"

