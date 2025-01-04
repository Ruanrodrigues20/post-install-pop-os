# Post-Install Script for Pop!_OS or Debian and Derivatives

This script automates the installation and configuration process of a series of useful programs and tools for Pop!_OS (or other distributions based on Ubuntu/Debian).

It performs the following operations:
- Updates the system.
- Installs essential software packages.
- Downloads and installs `.deb` packages.
- Installs additional tools such as **Oh My Bash**, **IntelliJ**, **Maven**, among others.
- Configures the environment with environment variables like `JAVA_HOME` and `MAVEN_HOME`.

---

## Features

The script performs the following operations:

1. **System Update:**
   - Updates the system packages using `apt update` and `apt upgrade`.
   
2. **Installation of Essential Software:**
   - Installs tools such as `curl`, `wget`, `git`, `neofetch`, `vlc`, `discord`, `vim`, `libreoffice`, among others.

3. **Download `.deb` Packages:**
   - Downloads `.deb` files for **Java 21** and **Visual Studio Code**.

4. **Install `.deb` Packages:**
   - Installs the downloaded `.deb` packages and removes the `.deb` files after installation.

5. **Install IntelliJ:**
   - Clones the IntelliJ installation repository and runs the installation script.

6. **Install Fastfetch:**
   - Installs **Fastfetch** from a PPA repository.

7. **Install Maven and Configure Environment:**
   - Downloads and installs **Maven**, setting the environment variables `MAVEN_HOME` and `PATH`.

8. **Set JAVA_HOME:**
   - Defines the Java path (`JAVA_HOME`) in the `.bashrc` file to facilitate the use of Java in the terminal.


9. **Set config global Git:**
   - Defines the your user.name and user.email for global git settings



10. **Clean up and Remove Temporary Files:**
   - Removes downloaded `.deb` packages, cleans package cache, and removes unnecessary packages.


---

## Prerequisites

- **Pop!_OS** or another **Ubuntu/Debian**-based distribution.
- **Superuser permissions** (sudo) to install packages and make system changes.
- **Internet connection** to download packages and installation scripts.

---

## How to Use

### Steps:


1. **Clone the repository or download the script:**

   If you don't have the script locally, run the following command to clone the repository:

   ```bash
   git clone https://github.com/Ruanrodrigues20/post-install-pop-os.git
   cd post-install-pop-os

   

2. **Grant execution permissions to the script:**
   If the file is not executable, use the following command to grant permissions:



    ```bash
    chmod +x script.sh

3. **Run the script:**
   To run the script, just execute the following command in the terminal:
  
    ```bash
    ./script.sh
 
   
Wait for the script to complete. It will perform several installations and configurations on your system.
During execution, it will clean up temporary files and set environment variables.


4. **Restart the terminal or system**
   To ensure all environment variables are loaded correctly, restart the terminal or your system.

---

## Script Structure

The script is divided into several functions that can be called separately if needed:

- **Function `up`**: Updates the system and fixes broken packages.
- **Function `install`**:Installs essential packages.
- **Function `downloadDeb`**:  Downloads .deb packages (Java 21, VSCode and Virtual Box).
- **Function `installDebs`**: Installs packages `.deb` and clean up the files.
- **Function `installIntellij`**: Installs IntelliJ IDEA.
- **Function `installfastfetch`**: Installs  Fastfetch.
- **Function `installOhMyBash`**: Installs Oh My Bash.
- **Function `installMaven`**:  Installs Maven and configures MAVEN_HOME and PATH.
- **Function `setarJavaHome`**:  Sets the JAVA_HOME environment variable.
- **Function `removerLixo`**: Cleans temporary files, packages, and unnecessary directories.

---

## Notes

- The script should run successfully on other Debian/Ubuntu-based distributions, but it has been primarily tested on **Pop!_OS**.

---

## Contribution

Feel free to open issues or pull requests for improvements to the script.
---

## License

This project is licensed under the MIT License - see the[LICENSE](LICENSE.txt) file for more details.

