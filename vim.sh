#! /bin/bash -e

ORIGINAL_DIR=$(pwd)

REPO_URL="git://github.com/brodul/dotvim.git"

VIM_CONF_DIR="/tmp/vim_dir/"

# We want to expand aliases in a script
shopt -s expand_aliases


# Activation
############

# If you call this script with any argument it just activates the configuration
if [ -d "$VIM_CONF_DIR" ]; then
    alias vim=" VIMRUNTIME=$VIM_CONF_DIR.vim vim -u $VIM_CONF_DIR.vimrc"
else


# Install
#########

# Check if git installed
which git > /dev/null
if [ "$?" -ne "0" ]; then
    echo "Please install git!!!"
fi


# remove old repository
rm -rf $VIM_CONF_DIR > /dev/null 2>&1

mkdir -p $VIM_CONF_DIR
cd $VIM_CONF_DIR

# Clone repository
git clone $REPO_URL .vim

cd .vim
git submodule init && git submodule update > /dev/null

cd ..

ln -s .vim/.vimrc
ln -s .vim/.gvimrc

alias vim=" VIMRUNTIME=$VIM_CONF_DIR.vim vim -u $VIM_CONF_DIR.vimrc"


# Clean up
rm -rf dotvim > /dev/null 2>&1
cd $ORIGINAL_DIR
fi
