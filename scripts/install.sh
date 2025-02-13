#!/bin/bash 

#------------------------------------------------------------------------------- #
# -------------------------------TESTS AND REQUIREMENTS----------------------------------------- #

# Is internet connected?
test_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
   printRed "[ERROR] - Your computer is not connected to the Internet. Please check your network."
  exit 1
else
  printGreen "[INFO] - Internet connection is working fine."
fi
}

# ------------------------------------------------------------------------------ #


#------------------------------------------------------------------------------- #
# ------------------------------- UPDATES and ADD REPOSITORIES ----------------------------------------- #

# Update
up(){
    printBlue "1. Updating System."
    echo ""

    apt update && apt upgrade -y
}


remove_lock(){
    # Check if there are any apt or dpkg processes running
    if pgrep -x "apt" >/dev/null || pgrep -x "dpkg" >/dev/null; then
        exit 1
    else
        # Remove the apt/dpkg locks
        sudo rm -rf /var/lib/dpkg/lock*
        sudo rm -rf /var/lib/apt/lists/lock
        sudo dpkg --configure -a
        sudo apt autoclean -y
    fi
}


addRepositories(){
    add-apt-repository ppa:flatpak/stable -y 
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo -y
    apt update
}

# ------------------------------------------------------------------------------ #


#------------------------------------------------------------------------------- #
# ------------------------------- INSTALL PROGRAMS ----------------------------------------- #

# Install programs
install(){
    echo ""
    printBlue "2. Installing programs."
    echo ""

    # List of packages to be installed
    packages=(
        curl
        wget
        dpkg
        git
        tree
        neofetch
        discord
        vlc
        vim
        flatpak
        gnome-software-plugin-flatpak
        folder-color 
        gnome-sushi
	gnome-tweaks
	gnome-shell-extension-manager
        maven 
    )
    installPackages "${packages[@]}"
}


installFlatpaks(){
    echo ""
    printBlue "3. Installing flatpak programs."
    echo ""

    # List of packages in the "remote package" format
    flatpak_packages=(
        #"io.github.flattool.Warehouse"
        #"me.iepure.devtoolbox"
        #"flatpak install flathub io.mrarm.mcpelauncher"
    )

    # Add repositories if necessary (e.g., for flathub)
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    for package in "${flatpak_packages[@]}"; do
        echo "Installing: $app_id from remote $remote..."

        # Try to install the package at the system level
        flatpak install $package -y
        if [ $? -eq 0 ]; then
            printGreen "Package $app_id successfully installed!"
            continue
        else
            printRed "Error installing package $app_id. Check the logs for more details." >&2
        fi

    done
}



# Download deb programs
downloadDeb(){
    echo ""
    printBlue "4. Downloading deb packages."
    echo ""

    # Java 21
    wget -c https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb

    # Vs code
    wget -c https://vscode.download.prss.microsoft.com/dbazure/download/stable/fabdb6a30b49f79a7aba0f2ad9df9b399473380f/code_1.96.2-1734607745_amd64.deb

   
}


# Install deb packages
installDebs(){
    echo ""
    printBlue "5. Installing deb programs."
    echo ""

    for package in *.deb; do
        echo -n "Installing $package..."
        sudo dpkg -i "$package"
        if [ $? -eq 0 ]; then
            echo " - Installed successfully!"
        else
            echo " - Failed to install."
        fi
    done
    rm *.deb
}

# ------------------------------------------------------------------------------ #


animation(){
    local pid=$1
    local spinstr='|/-\\'
    local i=0
    while [ -d /proc/$pid ]; do
        # Clear the line before printing the next symbol
        printf "\r[${spinstr:$i:1}] Building"  
        sleep 0.1
        ((i=(i+1)%4))  # Controls the rotation of the symbol
    done
    echo ""
}


#------------------------------------------------------------------------------- #
# ------------------------------- UTILS ----------------------------------------- #

installPackages(){

    local packages=("$@")
    for package in "${packages[@]}"; do
        echo "Installing: $package..."
        apt install -y "$package" >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            printGreen "Package $package installed successfully!"
        else
            printRed "Failed to install $package." >&2
        fi
    done


    apt --fix-broken install -y
}

printRed(){
    local text="$1"
    echo -e "\e[31m$text\e[0m"
}


printGreen() {
    local text="$1"
    echo -e "\e[32m$text\e[0m"
}

printBlue(){
    local text="$1"
    echo -e "\e[34m$text\e[0m"
}


# ------------------------------------------------------------------------------ #


#------------------------------------------------------------------------------- #
# ------------------------------- MORE SCRIPTS ----------------------------------------- #

# Install Intellij
installIntellij(){
    echo ""
    printBlue "6. Installing Intellij Ultimate."
    echo ""

    cd intellij/
    chmod +x install.sh
    ./install.sh
    cd ..
}

theme(){
   chmod +x theme.sh
   sudo ./theme.sh
}

installOhMyBash(){
    printBlue "Installing Oh My Bash..."

    # Run the installation in the background so it doesn't block the script
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" &

    printGreen "Oh My Bash has been installed. Changes will take effect in the next terminal session."

}



# ------------------------------------------------------------------------------ #




#------------------------------------------------------------------------------ #
# ------------------------------- CONFIGS ----------------------------------------- #

# Install fastfetch
installfastfetch(){
    echo ""
    printBlue "7. Installing Fastfetch."
    add-apt-repository ppa:zhangsongcui3371/fastfetch -y
    apt update
    apt install fastfetch -y
}


# Set JAVA_HOME to PATH
setJavaHome(){
    echo -e "\nJAVA_HOME=/usr/lib/jvm/jdk-21.0.6-oracle-x64/\nexport JAVA_HOME\nexport PATH=\$PATH:\$JAVA_HOME" >> ~/.bashrc
    source .bashrc
    $JAVA_HOME
}


setupPythonEnv() {
    echo ""
    printBlue "8. Installing and setting up Python environment."
    echo ""


    echo "Updating the system..."
    up 

    echo "Installing python3-venv, python3-poetry, and pipx..."
    packages=(python3-venv python3-poetry pipx)

    installPackages "${packages[@]}"

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
    printBlue "9. Configuring global git."
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


removeTrash(){
    echo ""
    printBlue "10. Removing temporary files."
    echo ""

    rm .deb
    apt autoremove -y
    apt clean
}


reboot_system(){
    # Ask if the user wants to reboot
    read -p "Do you want to reboot the system now? (y/n): " response

    # Check the response
    if [[ "$response" == "y" || "$response" == "Y" ]]; then
        echo "Rebooting the system..."
        sudo reboot
    else
        echo "System will not be rebooted. You can reboot manually later."
    fi
}

# ------------------------------------------------------------------------------ #



main(){
    test_internet
    remove_lock
    up
    addRepositories
    remove_lock
    install
    addFlatpakRep   
    installFlatpaks
    downloadDeb
    installDebs
    installIntellij
    #installfastfetch
    #setJavaHome
    #setupPythonEnv
    #configGit
    #theme
    removeTrash
    #installOhMyBash
    reboot_system
    #fastfetch
}

main
