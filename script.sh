#!/bin/bash 


#Atulizar
up(){
   sudo apt update 
   sudo apt upgrade -y
   sudo dpkg --configure -a
}


#instalar programas
install(){
    sudo apt install curl -y
    sudo apt install wget -y
    sudo apt install dpkg -y
    sudo apt install git -y
    sudo apt install neofetch -y
    sudo apt install discord -y
    sudo apt install vlc -y
    sudo apt install cpufetch -y
    sudo apt install bpytop -y
    sudo apt install hollywood -y
    sudo apt install vim -y
    sudo apt install libreoffice -y
    sudo apt install gimp -y
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
    sudo dpkg -i *.deb
    sudo rm *.deb
}



#Instalar intellij
installIntellij(){
    git clone https://github.com/Ruanrodrigues20/intelliJ-install.git
    cd intelliJ-install/
    chmod +x install.sh
    ./install.sh
}


#instalar fastfetch
installfastfetch(){
    sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
    sudo apt update
    sudo apt install fastfetch -y
}



#instalar oh my bash
installOhMyBash(){
    sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
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
    sudo rm *.deb
    rm -rf intelliJ-install/
    sudo apt clean
    sudo apt autoremove -y
}





up
clear
install
clear
up
downloadDeb
installDebs
clear
up
installIntellij
clear
installfastfetch
clear
up
installMaven
clear
setarJavaHome
clear
removerLixo
clear
fastfetch



