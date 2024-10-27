#!/bin/bash
set -o errexit
set -o pipefail
set -o noclobber
set -o nounset
set -o allexport
main() {
    echo "Using stow to install dotfiles"
    if ! command -v stow &> /dev/null; then
        if command -v apt-get &> /dev/null; then
            sudo apt-get install -y stow
        elif command -v brew &> /dev/null; then
            brew install stow
        elif command -v pacman &> /dev/null; then
            sudo pacman -S stow
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y stow
        elif command -v zypper &> /dev/null; then
            sudo zypper install -y stow
        elif command -v apk &> /dev/null; then
            sudo apk add stow
        elif command -v pkg &> /dev/null; then
            sudo pkg install -y stow
        elif command -v xbps-install &> /dev/null; then
            sudo xbps-install -S stow
        elif command -v emerge &> /dev/null; then
            sudo emerge -av stow
        elif command -v nix-env &> /dev/null; then
            nix-env -i stow
        elif command -v guix package &> /dev/null; then
            guix package -i stow
        else
            echo "No package manager found. Please install stow manually."
            exit 1
        fi
    fi
    if ! command -v stow &> /dev/null; then
        echo "stow is not installed. Please install it first."
        exit 1
    fi
    stow -v -t "$HOME" .
    echo " (*) Done!"
}
main "$@"