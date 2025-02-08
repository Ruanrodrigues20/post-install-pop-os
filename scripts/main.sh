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

install_script