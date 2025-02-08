#!/bin/bash


install_script() {
  # Clona o repositório

  sudo apt install git -y
  sudo apt install wget -y
  sudo apt install curl -y
  git clone https://github.com/Ruanrodrigues20/post-install-pop-os.git
  
  # Navega até o diretório do repositório
  cd post-install-pop-os
  
  # Concede permissão de execução ao script
  chmod +x install.sh
  
  # Executa o script com sudo
  sudo ./install.sh
}


menu() {
    # Display the ASCII art from logo.txt
    cat logo.txt
    echo ""

    # Ask the user if they are ready
    read -p "Are you ready? (y/n) " answer

    if [[ "$answer" =~ ^[Yy]$ ]]; then
        echo "Great! Let's get started..."
        # Continue with the rest of your script here.
    else
        echo "Please come back when you're ready."
        exit 1
    fi
}


main(){
    menu 
    install_script
}