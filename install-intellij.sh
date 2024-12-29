#!/bin/bash

main(){
    git clone https://github.com/Ruanrodrigues20/intelliJ-install.git
    cd intelliJ-install
    chmod +x install.sh
    #./install.sh
    cd ..
    sudo rm -rf intelliJ-install/
}

main