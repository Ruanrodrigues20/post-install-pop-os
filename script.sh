#!/bin/bash 


#Atulizar
up(){
    apt update 
    apt upgrade -y
    dpkg --configure -a
}



addRepositories(){
    add-apt-repository ppa:flatpak/stable -y
    apt update 
}

addFlatpakRep(){
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo -y
}


#instalar programas
install(){

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
        apt install -y "$pacote"
        if [ $? -eq 0 ]; then
            echo "Pacote $pacote instalado com sucesso!"
        else
            echo "Falha ao instalar $pacote." >&2
        fi
    done
}




installFlatpaks(){
    # Lista de pacotes no formato "remoto pacote"
    pacotesP=(
        "flathub io.github.flattool.Warehouse"
        "flathub me.iepure.devtoolbox"
    )

    for pacote in "${pacotesP[@]}"; do
        # Separar remoto e pacote
        read -r remoto app_id <<< "$pacote"
        echo "Instalando: $app_id do remoto $remoto..."

        # Instalar o pacote no nível system ou user
        flatpak install --assumeyes --system "$remoto" "$app_id" 2>/dev/null || \
        flatpak install --assumeyes --user "$remoto" "$app_id"

        # Verificar se a instalação foi bem-sucedida
        if [ $? -eq 0 ]; then
            echo "Pacote $app_id instalado com sucesso!"
        else
            echo "Falha ao instalar $app_id do remoto $remoto." >&2
        fi
    done
}







#Baixar programas deb
downloadDeb(){
    #Java 21
    wget -c https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
    
    #Vs code
    wget -c https://vscode.download.prss.microsoft.com/dbazure/download/stable/fabdb6a30b49f79a7aba0f2ad9df9b399473380f/code_1.96.2-1734607745_amd64.deb
}
    
    
#instalar debs
installDebs(){
    dpkg -i *.deb
    rm *.deb
}



#Instalar intellij
installIntellij(){
    ./install-intellij.sh
}


#instalar fastfetch
installfastfetch(){
    add-apt-repository ppa:zhangsongcui3371/fastfetch -y
    apt update
    apt install fastfetch -y
}



#instalar oh my bash
installOhMyBash(){
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
}





#instalar maven e adicionando ao PATH
installMaven(){
    wget -c https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
    tar -xzvf apache-maven-3.9.9-bin.tar.gz
    rm *.gz
    mv apache* maven
    mkdir .maven
    mv maven .maven/
    echo -e "\nexport MAVEN_HOME=\$HOME/.maven/maven\nexport PATH=\$MAVEN_HOME/bin:\$PATH" >> ~/.bashrc
    source .bashrc
    mvn -v
}



#adicionando o JAVA_HOME ao PATH
setarJavaHome(){
    echo -e "\nJAVA_HOME=/usr/lib/jvm/jdk-21.0.5-oracle-x64/\nexport JAVA_HOME\nexport PATH=\$PATH:\$JAVA_HOME" >> ~/.bashrc
    source .bashrc
    $JAVA_HOME
}

removerLixo(){
    rm *.deb
    rm -rf intelliJ-install/
    apt clean
    apt autoremove -y
}



main(){
    up
    addRepositories
    install
    addFlatpakRep   
    downloadDeb
    installDebs
    installIntellij
    installfastfetch
    installMaven
    setarJavaHome
    removerLixo
    fastfetch
}



installFlatpaks

