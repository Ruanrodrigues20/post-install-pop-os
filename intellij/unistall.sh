#!/bin/bash

echo "Removendo IntelliJ IDEA..."

# Verifica se o diretório de instalação existe
if [ -d "/opt/intellij-idea" ]; then
    # Remove o diretório de instalação
    sudo rm -rf /opt/intellij-idea
    echo "Diretório /opt/intellij-idea removido."
else
    echo "O IntelliJ IDEA não foi encontrado em /opt/intellij-idea."
fi

# Remove o link simbólico do comando 'idea'
if [ -L "/usr/local/bin/idea" ]; then
    sudo rm /usr/local/bin/idea
    echo "Link simbólico /usr/local/bin/idea removido."
else
    echo "Link simbólico /usr/local/bin/idea não encontrado."
fi

# Remove o arquivo do menu de aplicativos .desktop
if [ -f "/usr/share/applications/intellij-idea.desktop" ]; then
    sudo rm /usr/share/applications/intellij-idea.desktop
    echo "Arquivo do menu de aplicativos removido."
else
    echo "Arquivo do menu de aplicativos não encontrado."
fi

# Atualiza o banco de dados do menu de aplicativos
echo "Atualizando banco de dados do menu de aplicativos..."
sudo update-desktop-database

echo "IntelliJ IDEA foi removido com sucesso!"