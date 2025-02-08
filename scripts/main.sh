#!/bin/bash
set -e  # Para o script em caso de erro

install_script() {
  # Clona o repositório e instala dependências básicas
  sudo apt update
  sudo apt install -y git wget curl
  
  # Clona o repositório
  git clone https://github.com/Ruanrodrigues20/post-install-pop-os.git
  
  # Navega até o diretório do repositório
  cd post-install-pop-os || exit
  
  # Concede permissão de execução ao script
  chmod +x install.sh
  
  # Executa o script com sudo
  sudo ./install.sh
}

menu() {
    # Exibe a arte ASCII do arquivo logo.txt
    echo ".########...#######...######.....####.##....##..######..########....###....##.......##......
.##.....##.##.....##.##....##.....##..###...##.##....##....##......##.##...##.......##......
.##.....##.##.....##.##...........##..####..##.##..........##.....##...##..##.......##......
.########..##.....##..######......##..##.##.##..######.....##....##.....##.##.......##......
.##........##.....##.......##.....##..##..####.......##....##....#########.##.......##......
.##........##.....##.##....##.....##..##...###.##....##....##....##.....##.##.......##......
.##.........#######...######.....####.##....##..######.....##....##.....##.########.########"
    echo ""

    # Pergunta se o usuário está pronto
    read -p "Are you ready? (y/n) " answer

    if [[ "$answer" =~ ^[Yy]$ ]]; then
        echo "Great! Let's get started..."
    else
        echo "Please come back when you're ready."
        exit 1
    fi
}

main() {
    menu
    install_script
}

main
