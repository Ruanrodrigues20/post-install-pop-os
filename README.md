# Post-Install Script for Pop!_OS ou Debian e derivados


Este script automatiza o processo de instalação e configuração de uma série de programas e ferramentas úteis para o Pop!_OS (ou outras distribuições baseadas no Ubuntu/Debian).

Ele realiza as seguintes operações:
- Atualiza o sistema.
- Instala pacotes de programas essenciais.
- Baixa e instala pacotes `.deb`.
- Instala ferramentas adicionais como **Oh My Bash**, **IntelliJ**, **Maven**, entre outros.
- Configura o ambiente com variáveis de ambiente, como `JAVA_HOME` e `MAVEN_HOME`.

---

## Funcionalidades

O script realiza as seguintes operações:

1. **Atualização do sistema:**
   - Atualiza os pacotes do sistema com `apt update` e `apt upgrade`.
   
2. **Instalação de programas essenciais:**
   - Instala ferramentas como `curl`, `wget`, `git`, `neofetch`, `vlc`, `discord`, `vim`, `libreoffice`, entre outros.

3. **Download de pacotes `.deb`:**
   - Baixa arquivos `.deb` para o **Java 21** e **Visual Studio Code**.

4. **Instalação de pacotes `.deb`:**
   - Instala os pacotes `.deb` baixados e remove os arquivos `.deb` após a instalação.

5. **Instalação do IntelliJ:**
   - Clona o repositório de instalação do IntelliJ e executa o script de instalação.

6. **Instalação do Fastfetch:**
   - Instala o **Fastfetch** de um repositório PPA.

7. **Instalação do Maven e configuração do ambiente:**
   - Baixa e instala o **Maven**, configurando as variáveis de ambiente `MAVEN_HOME` e `PATH`.

8. **Configuração do JAVA_HOME:**
   - Define o caminho do Java (`JAVA_HOME`) no arquivo `.bashrc` para facilitar o uso do Java no terminal.

9. **Limpeza e remoção de arquivos temporários:**
   - Remove pacotes `.deb` baixados, limpa o cache de pacotes e remove pacotes desnecessários.

---

## Pré-requisitos

- **Pop!_OS** ou outra distribuição baseada em **Ubuntu/Debian**.
- **Permissões de superusuário** (sudo) para instalar pacotes e realizar mudanças no sistema.
- **Conexão com a internet** para baixar pacotes e scripts de instalação.

---

## Como usar

### Passos:

1. **Clone o repositório ou baixe o script:**

   Caso você não tenha o script localmente, execute o comando abaixo para clonar o repositório:

   ```bash
   git clone https://github.com/seu-usuario/post-install-pop-os.git
   cd post-install-pop-os
   

2. **Dê permissões de execução ao script:**
   Se o arquivo não for executável, use o comando abaixo para dar permissões:

    ```bash
    chmod +x script.sh

3. **Execute o script:**
   Para rodar o script, basta executar o seguinte comando no terminal:
  
    ```bash
    ./script.sh
 
  Aguarde a execução do script. O script fará várias instalações e configurações no seu sistema.  
  Durante a execução, ele limpará os arquivos temporários e configurará as variáveis de ambiente.

4. **Reinicie o terminal ou o sistema**
    Para garantir que todas as variáveis de ambiente sejam corretamente carregadas, reinicie o terminal ou o sistema.

---

## Estrutura do Script

O script é dividido em várias funções que podem ser chamadas separadamente, se necessário:

- **Função `up`**: Atualiza o sistema e configura pacotes quebrados.
- **Função `install`**: Instala pacotes essenciais.
- **Função `downloadDeb`**: Baixa pacotes `.deb` (Java 21 e VSCode).
- **Função `installDebs`**: Instala pacotes `.deb` e limpa os arquivos.
- **Função `installIntellij`**: Instala o IntelliJ IDEA.
- **Função `installfastfetch`**: Instala o Fastfetch.
- **Função `installOhMyBash`**: Instala o Oh My Bash.
- **Função `installMaven`**: Instala o Maven e configura o `MAVEN_HOME` e o `PATH`.
- **Função `setarJavaHome`**: Configura a variável de ambiente `JAVA_HOME`.
- **Função `removerLixo`**: Limpa arquivos temporários, pacotes e diretórios desnecessários.

---

## Observações

- O script deve ser executado com êxito em outras distribuições baseadas em Debian/Ubuntu, mas foi testado principalmente no **Pop!_OS**.

---

## Contribuição

Sinta-se à vontade para abrir issues ou pull requests para melhorias no script.

---

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE.txt) para mais detalhes.

