#!/bin/bash


if [ -z "$1" ]; then
    echo "Nenhuma versão fornecida. Usando a versão padrão."
    LATEST_VERSION="2024.3.2.2"  # Versão padrão
else
    LATEST_VERSION="$1" 
fi

echo "Instalando IntelliJ IDEA versão: ${LATEST_VERSION}"


# URL base para o download
BASE_URL="https://download-cdn.jetbrains.com/idea/"

# Baixar a versão específica
DOWNLOAD_URL="${BASE_URL}ideaIU-${LATEST_VERSION}.tar.gz"
echo "Baixando IntelliJ IDEA versão ${LATEST_VERSION}..."

curl -L -O "$DOWNLOAD_URL"

# Verificar se o download foi concluído
if [ ! -f "ideaIU-${LATEST_VERSION}.tar.gz" ]; then
    echo "Erro: Download falhou. Verifique sua conexão ou o link."
    exit 1
fi

# Extrair o arquivo tar.gz
tar -xvzf "ideaIU-${LATEST_VERSION}.tar.gz" >/dev/null 2>&1

# Renomear a pasta extraída para 'idea'
mv idea-* idea

# Mover a pasta para o diretório /opt
sudo mv idea /opt/intellij-idea

# Criar link simbólico para o comando 'idea'
sudo ln -s /opt/intellij-idea/bin/idea.sh /usr/local/bin/idea

# Garantir que o arquivo tenha permissões executáveis
sudo chmod +x /usr/local/bin/idea

# Criar arquivo .desktop para menu de aplicativos
sudo bash -c 'cat > /usr/share/applications/intellij-idea.desktop <<EOF
[Desktop Entry]
Name=IntelliJ IDEA
Comment=Edição Comunitária do IntelliJ IDEA
Exec=/opt/intellij-idea/bin/idea.sh %f
Icon=/opt/intellij-idea/bin/idea.png
Terminal=false
Type=Application
Categories=Desenvolvimento;IDE;
StartupWMClass=jetbrains-idea
EOF'

# Atualizar banco de dados do menu de aplicativos
sudo update-desktop-database

# Limpeza do arquivo baixado
echo "Limpando arquivos temporários..."
rm "ideaIU-${LATEST_VERSION}.tar.gz"

echo "Instalação concluída! Você pode iniciar o IntelliJ IDEA com o comando 'idea' ou pelo menu de aplicativos."