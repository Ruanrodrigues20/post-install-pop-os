#!/bin/bash 

animation(){
    local pid=$1
    local spinstr='|/-\\'
    local i=0
    while [ -d /proc/$pid ]; do
        # Limpa a linha antes de imprimir o próximo símbolo
        printf "\r[${spinstr:$i:1}] Building"  
        sleep 0.1
        ((i=(i+1)%4))  # Controla a rotação do símbolo
    done
    echo ""
}




#Atulizar
up(){
    printBlue "1. Updating System."
    echo ""

    apt update  >/dev/null 2>&1 && apt upgrade -y >/dev/null 2>&1 &
    pid=$!
    animation $pid
    rm /var/cache/apt/archives/lock >/dev/null 2>&1
}




addRepositories(){
    add-apt-repository ppa:flatpak/stable -y >/dev/null 2>&1
    apt update >/dev/null 2>&1
}

addFlatpakRep(){
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo -y >/dev/null 2>&1
}



#instalar programas
install(){
    echo ""
    printBlue "2. Installation of programs."
    echo ""

    # Lista de pacotes a serem instalados
    pacotes=(
        curl
        wget
        dpkg
        git
        tree
        neofetch
        discord
        vlc
        #cpufetch
        #hollywood
        vim
        libreoffice
        gimp
        flatpak
        gnome-software-plugin-flatpak
        #lutris
        #steam
        folder-color 
        gnome-sushi
    )

    installPackages "${pacotes[@]}"
}



installPackages(){

    local pacotes=("$@")
    for pacote in "${pacotes[@]}"; do
        echo "Instalando: $pacote..."
        apt install -y "$pacote" >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            printGreen "Pacote $pacote instalado com sucesso!"
        else
            printRed "Falha ao instalar $pacote." >&2
        fi
    done
}

printRed(){
    local texto="$1"
    echo -e "\e[31m$texto\e[0m"
}


printGreen() {
    local texto="$1"
    echo -e "\e[32m$texto\e[0m"
}

printBlue(){
    local texto="$1"
    echo -e "\e[34m$texto\e[0m"
}



installFlatpaks(){
    echo ""
    printBlue "3. Installing flatpak programs."
    echo ""

    # Lista de pacotes no formato "remoto pacote"
    pacotesP=(
        #"io.github.flattool.Warehouse"
        #"me.iepure.devtoolbox"
        #"flatpak install flathub io.mrarm.mcpelauncher"
    )

    # Adicionar reposit�rios se necess�rio (exemplo para flathub)
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    for pacote in "${pacotesP[@]}"; do
        # Separar remoto e pacote
        echo "Instalando: $app_id do remoto $remoto..."

        # Tente instalar o pacote no n�vel system
        flatpak install $pacote -y
        if [ $? -eq 0 ]; then
            printGreen "Pacote $app_id instalado com sucesso no sistema!"
            continue
        else
            printRed "Erro ao instalar o pacote $app_id. Verifique os logs para mais detalhes." >&2
        fi

    done
}





#Baixar programas deb
downloadDeb(){
    echo ""
    printBlue "4. Download packgage debs."
    echo ""

    #Java 21
    wget -c https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
    
    #virtual box
    #wget -c https://download.virtualbox.org/virtualbox/7.1.4/virtualbox-7.1_7.1.4-165100~Ubuntu~noble_amd64.deb
    #Vs code
    wget -c https://vscode.download.prss.microsoft.com/dbazure/download/stable/fabdb6a30b49f79a7aba0f2ad9df9b399473380f/code_1.96.2-1734607745_amd64.deb
}



    
#instalar debs
installDebs(){
    echo ""
    printBlue "5. Installing deb programs."
    echo ""

    for pacote in *.deb; do
        echo -n "Instalando $pacote..."
        sudo dpkg -i "$pacote" >/dev/null 2>&1 &
        pid=$!
        animation $pid
        if [ $? -eq 0 ]; then
            echo " - Instalado com sucesso!"
        else
            echo " - Falha ao instalar."
        fi
    done
    rm *.deb
    
}




#Instalar intellij
installIntellij(){
    echo ""
    printBlue "6. Installing Intellij Ultimate."
    echo ""

    cd intellij/
    chmod +x install.sh
    ./install.sh
    cd ..
}



#instalar fastfetch
installfastfetch(){
    echo ""
    printBlue "7. Instalando Fastfetch."
    add-apt-repository ppa:zhangsongcui3371/fastfetch -y >/dev/null 2>&1 &
    pid=$!
    animation $pid
    apt update >/dev/null 2>&1 &
    pid=$!
    animation $pid
    apt install fastfetch -y >/dev/null 2>&1 &
    pid=$!
    animation $pid
}



#instalar oh my bash
installOhMyBash(){
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
}





#instalar maven e adicionando ao PATH
installMaven(){

    wget -c https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz &
    pid=$!
    animation $pid
    tar -xzvf apache-maven-3.9.9-bin.tar.gz >/dev/null 2>&1 &
    pid=$!
    animation $pid
    rm *.gz
    mv apache maven
    mkdir ~/.maven
    mv maven ~/.maven/
    echo -e "\nexport MAVEN_HOME=\$HOME/.maven/maven\nexport PATH=\$MAVEN_HOME/bin:\$PATH" >> ~/.bashrc
    source ~/.bashrc
    mvn -v
}



#adicionando o JAVA_HOME ao PATH
setarJavaHome(){
    echo -e "\nJAVA_HOME=/usr/lib/jvm/jdk-21.0.6-oracle-x64/\nexport JAVA_HOME\nexport PATH=\$PATH:\$JAVA_HOME" >> ~/.bashrc
    source .bashrc
    $JAVA_HOME
}



setupPythonEnv() {
    echo ""
    printBlue "8. Installing setup Python Env."
    echo ""


    echo "Updating the system..."
    up  >/dev/null 2>&1

    echo "Installing python3-venv, python3-poetry e pipx..."
    pacotes=(python3-venv python3-poetry pipx)
    
    installPackages "${pacotes[@]}"

    echo "Ensuring pipx is in the PATH..."
    pipx ensurepath
    source ~/.bashrc || source ~/.zshrc

    echo "Installing virtualenv using pipx..."
    pipx install virtualenv

    echo "Configuring Poetry to create virtual environments in the project directory..."
    poetry config virtualenvs.in-project true

    echo "Installation complete!"
}

configGit(){
    echo ""
    printBlue "9. Config global git."
    echo ""
  
    echo -n  "Enter your user.name: "
    read user
    echo "You typed your user.name: $user"
    
    echo ""

    echo -n  "Enter your user.email: "
    read email
    echo "You typed your user.email: $email"

    echo ""


    if [[ -n "$user" && -n "$email" ]]; then
        git config --global user.name "$user"
        git config --global user.email "$email"
        printGreen "Git global config updated successfully!"
    else
        printRed "Error: Both user.name and user.email must be provided."
    fi

}



removerLixo(){
    echo ""
    printBlue "10. Removing temporary files."
    echo ""

    rm .deb
    apt autoremove -y >/dev/null 2>&1
    apt clean
}



main(){
    #up
    #addRepositories
    #install
    #addFlatpakRep   
    #installFlatpaks
    #downloadDeb
    #installDebs
    #installIntellij
    #installfastfetch
    #setarJavaHome
    setupPythonEnv
    #configGit
    #removerLixo
    #fastfetch
}

main
