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
   - Defines the your `user.name` and `user.email` for global git settings.

10. **Clean up and Remove Temporary Files:**
   - Removes downloaded `.deb` packages, cleans package cache, and removes unnecessary packages.

---

## Prerequisites

- **Pop!_OS** or another **Ubuntu/Debian**-based distribution.
- **Superuser permissions** (sudo) to install packages and make system changes.
- **Internet connection** to download packages and installation scripts.

---

## How to Use

To run the script, you can use one of the following commands, depending on whether you prefer `curl` or `wget`:

#### Using `curl`:
```bash
bash <(curl -s https://raw.githubusercontent.com/Ruanrodrigues20/post-install-pop-os/main/scripts/main.sh)

#### Using `wget`:
bash <(wget -qO- https://raw.githubusercontent.com/Ruanrodrigues20/post-install-pop-os/main/scripts/main.sh)

### Steps:

1. **Clone the Repository or Download the Script:**

   If you do not have the script locally, run the following command to clone the repository:

   ```bash
   git clone https://github.com/Ruanrodrigues20/post-install-pop-os.git cd post-install-pop-os

2. **Grant Execution Permissions to the Script:**

   If the file is not executable, use the following command to grant permissions:

   ```bash
   chmod +x script.sh

---

3. **Run the Script:**

To execute the script, run the following command in the terminal:

```bash
./script.sh

Wait for the script to complete. It will install and configure several programs and tools, as well as make system optimizations.

4. Restart the Terminal or System:



After the script completes, it's recommended to restart the terminal or your system to ensure that environment variables and configurations take effect.


---

---

## Script Structure

The script is divided into several functions, each responsible for a specific task. Here is a detailed breakdown:

### Function Breakdown:

- **up()**: Updates the system and fixes broken packages.
- **install()**: Installs essential software packages.
- **downloadDeb()**: Downloads .deb packages (Java 21, VSCode, and more).
- **installDebs()**: Installs .deb packages and removes .deb files afterward.
- **installIntellij()**: Installs IntelliJ IDEA Ultimate.
- **installFastfetch()**: Installs Fastfetch.
- **installOhMyBash()**: Installs Oh My Bash.
- **installMaven()**: Installs Maven and configures environment variables for Maven.
- **setJavaHome()**: Sets the JAVA_HOME environment variable in the terminal.
- **removerLixo()**: Cleans temporary files, old packages, and unnecessary directories.
- **theme()**: Installs the White Sur GTK Theme, White Sur Icons, and White Sur Wallpaper.

---

## Additional Features

### White Sur GTK Theme:

This script applies the White Sur macOS-like theme to your system:

- **GTK Theme**: The script installs the White Sur GTK theme, transforming the look of your desktop environment to resemble macOS.
- **Icons**: It also installs the White Sur icon pack for a cohesive aesthetic.
- **Wallpaper**: Sets a White Sur wallpaper as the default background, completing the visual transformation.

---

## Notes

The script should run successfully on other Debian/Ubuntu-based distributions, but it has been primarily tested on Pop!_OS.

You may need to restart your terminal or system after running the script for all changes to take effect.


---

## Contribution

Feel free to open issues or pull requests if you have suggestions, improvements, or fixes for the script.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.txt) file for more details.