#!/bin/bash 

animation(){
    local pid=$1
    local spinstr='|/-\\'
    while [ -d /proc/$pid ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep 0.1
        printf "\b\b\b\b\b\b"
    done
}


#Atulizar
up(){
    echo "1. Updating System"

    apt update >/dev/null 2>&1 &
    pid=$!
    animation $pid
    apt upgrade -y >/dev/null 2>&1 &
    pid=$!
    animation $pid
    dpkg --configure -a >/dev/null 2>&1 &
    pid=$!
    animation $pid
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
    echo "2. Installation of programs"
    echo ""

    # Lista de pacotes a serem instalados
    pacotes=(
        curl
        wget
        dpkg
        git
        neofetch
        discord
        vlc
        cpufetch
        hollywood
        vim
        libreoffice
        gimp
        flatpak
        gnome-software-plugin-flatpak
    )

    # Instalando cada pacote com um laço
    for pacote in "${pacotes[@]}"; do
        echo "Instalando: $pacote..."
        apt install -y "$pacote" >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "Pacote $pacote instalado com sucesso!"
        else
            echo "Falha ao instalar $pacote." >&2
        fi
    done
}




installFlatpaks(){
    echo ""
    echo "3. Installing flatpak programs"
    echo ""

    # Lista de pacotes no formato "remoto pacote"
    pacotesP=(
        "io.github.flattool.Warehouse"
        "me.iepure.devtoolbox"
    )

    # Adicionar reposit�rios se necess�rio (exemplo para flathub)
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    for pacote in "${pacotesP[@]}"; do
        # Separar remoto e pacote
        read -r remoto app_id <<< "$pacote"
        echo "Instalando: $app_id do remoto $remoto..."

        # Tente instalar o pacote no n�vel system
        flatpak install $pacote -y
        if [ $? -eq 0 ]; then
            echo "Pacote $app_id instalado com sucesso no sistema!"
            continue
        fi

    done
}









#Baixar programas deb
downloadDeb(){
    echo ""
    echo "4. Download packgage debs"
    echo ""

    #Java 21
    wget -c https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
    
    #Vs code
    wget -c https://vscode.download.prss.microsoft.com/dbazure/download/stable/fabdb6a30b49f79a7aba0f2ad9df9b399473380f/code_1.96.2-1734607745_amd64.deb
}
    
    
#instalar debs
installDebs(){
    echo ""
    echo "5. Installing deb programs"
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
    echo "6. Installing Intellij Ultimate"
    echo ""

    cd intellij/
    chmod +x install.sh
    ./install.sh
    cd ..
}


#instalar fastfetch
installfastfetch(){
    echo ""
    echo "7. Instalando Fastfetch..."
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
    echo ""
    echo "8. Installing Maven"
    echo ""

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
    echo -e "\nJAVA_HOME=/usr/lib/jvm/jdk-21.0.5-oracle-x64/\nexport JAVA_HOME\nexport PATH=\$PATH:\$JAVA_HOME" >> ~/.bashrc
    source .bashrc
    $JAVA_HOME
}

removerLixo(){
    echo ""
    echo "9. Removing temporary files"
    echo ""

    rm *.deb
    rm -rf intelliJ-install/
    apt autoremove -y >/dev/null 2>&1
}



main(){
    up
    addRepositories
    install
    addFlatpakRep   
    installFlatpaks
    downloadDeb
    installDebs
    installIntellij
    installfastfetch
    installMaven
    setarJavaHome
    removerLixo
    fastfetch
}

main