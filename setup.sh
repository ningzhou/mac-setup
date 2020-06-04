#!/usr/bin/env bash

function run_setup() {
    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until the script has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # Run sections based on command line arguments
    for ARG in "$@"
    do
        if [ $ARG == "brew" ] || [ $ARG == "all" ]; then
            # Run the brew_install.sh Script
            # For a full listing of installed formulae and apps, refer to
            # the commented brew_install.sh source file directly 
            echo ""
            echo "------------------------------"
            echo "Installing Homebrew along with some common formulae and apps."
            echo "This might take a while to complete, as some formulae need to be installed from source."
            echo "------------------------------"
            echo ""
            bash brew_install.sh
        fi

        if [ $ARG == "omz" ] || [ $ARG == "all" ]; then
	    echo ""
	    echo "------------------------------"
	    echo "Installing oh-my-zsh"
	    echo "------------------------------"
	    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	    echo ""
        fi

        if [ $ARG == "config" ] || [ $ARG == "all" ]; then
            echo ""
            echo "------------------------------"
            echo "Syncing the configuration files for a number of apps into home directory."
            echo "------------------------------"
            echo ""
	    bash sync_config.sh
        fi

        if [ $ARG == "dotfiles" ] || [ $ARG == "all" ]; then
            echo ""
            echo "------------------------------"
            echo "Clone dot files from git and symbolically link to the right places"
            echo "------------------------------"
            echo ""
	    bash symlink_dotfiles.sh
    done

    echo "------------------------------"
    echo "Completed setting up with your options, restart your computer to ensure all updates take effect"
    echo "------------------------------"
}

read -p "This script may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    run_setup $@
fi;

unset run_setup;

