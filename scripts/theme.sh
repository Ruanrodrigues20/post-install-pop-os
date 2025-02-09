#!/bin/bash

clone_repositories(){
    echo "Clonando os repositórios do WhiteSur..."
    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-gtk-theme.git
    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-icon-theme.git
    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-wallpapers.git
}

install_gtk_theme(){
    echo "Instalando tema GTK..."
    cd WhiteSur-gtk-theme 
    ./install.sh
    cd ..
}

install_icon_theme(){
    echo "Instalando tema de ícones..."
    cd WhiteSur-icon-theme
    ./install.sh 
    cd ..
}

install_wallpaper(){
    echo "Instalando wallpapers..."
    cd WhiteSur-wallpapers 
    ./install-wallpapers.sh 
    cd ..
}

apply_themes(){
    echo "Ativando extensão User Themes..."
    gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com || \
    gnome-extensions install user-theme@gnome-shell-extensions.gcampax.github.com

    echo "Aplicando temas automaticamente..."
    gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-dark"
    gsettings set org.gnome.desktop.interface icon-theme "WhiteSur"

    echo "Instalação concluída! Agora aplique o wallpaper manualmente nas configurações."
}

main(){
    clone_repositories
    install_gtk_theme
    install_icon_theme
    install_wallpaper
    apply_themes
}

main
