#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "This script must be executed as root. Please, use sudo.";
    exit 1;
fi

echo -e "\nUNINSTALL DEFAULT APPLICATIONS";
sudo zypper remove -y --clean-deps marble kmines kmahjongg \
kpat kreversi ksudoku kontact hugin kmail ktnef xscreensaver \
akregator skanlite korganizer pim-sieve-editor \
pim-data-exporter akonadi-calendar-tools akonadi-contact \
akonadi-import-wizard akonadi-plugin-calendar \
akonadi-plugin-contacts akonadi-plugin-contacts \
akonadi-plugin-contacts akonadi-plugin-contacts xterm \
mariadb mailcommon mailimporter xscreensaver;

echo -e "\nINSTALL UTILITIES";
sudo zypper install neofetch helvum ksysguard5 symbols-only-nerd-fonts \
mariadb-client sensors xclip btop powerline-fonts ksystemlog bucklespring \
inkscape java-11-openjdk eclipse-jdt xournalpp;
sudo zypper install ruby3.2-rubygem-lolcat;

echo -e "\nINSTALL GOOGLE CHROME";
echo -e "[chrome]\nenabled=1\nautorefresh=1\nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64\ntype=rpm-md\npriority=100\ngpgcheck=1\ngpgkey=https://dl.google.com/linux/linux_signing_key.pub\n" > /etc/zypp/repos.d/repo-chrome.repo
sudo zypper refresh && sudo zypper install google-chrome-stable;

echo -e "\nINSTALL ZSH";
sudo zypper install zsh;
chsh -s $(which zsh);

echo -e "\nINSTALL VSCODE";
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
sudo zypper --gpg-auto-import-keys ar -n 'repo-code' -f https://packages.microsoft.com/yumrepos/vscode vscode && \
sudo zypper refresh && \
sudo zypper install code;

echo -e "\nINSTALL DOT NET SDK 8";
sudo zypper install libicu && \
wget  -P ~/Downloads/ https://packages.microsoft.com/config/opensuse/15/prod.repo && \
sudo mv ~/Downloads/prod.repo /etc/zypp/repos.d/microsoft-prod.repo &&\
sudo chown root:root /etc/zypp/repos.d/microsoft-prod.repo && \
sudo zypper install dotnet-sdk-8.0;

echo -e "\nINSTALL DBEAVER";
sudo zypper --gpg-auto-import-keys ar -n 'repo-dbeaver' \
-f https://download.opensuse.org/repositories/home:cabelo:innovators/openSUSE_Tumbleweed/home:cabelo:innovators.repo && \
sudo zypper refresh && sudo zypper mr --disable 'repo-dbeaver';

echo -e "\nINSTALL WAVEBOX";
curl -sSL https://download.wavebox.app/static/wavebox_repo.key | sudo gpg --import && \
sudo wget -P /etc/zypp/repos.d/ https://download.wavebox.app/stable/linux/rpm/wavebox.repo && \
sudo zypper install Wavebox;

echo -e "\nINSTALL DOCKER";
sudo zypper --gpg-auto-import-keys ar -n 'repo-docker' \
-f https://download.opensuse.org/repositories/home:cyphar:docker/openSUSE_Tumbleweed/home:cyphar:docker.repo && \
sudo zypper refresh && sudo zypper install docker && sudo zypper install yast2-docker && \
sudo zypper mr --disable 'repo-docker' && sudo usermod -aG docker $(whoami);

echo -e "\nINSTALL POSTMAN";
sudo zypper --gpg-auto-import-keys ar -n 'repo-postman' \
-f https://download.opensuse.org/repositories/home:gmsh/openSUSE_Tumbleweed/home:gmsh.repo && \
sudo zypper refresh && sudo zypper install postman && \
sudo zypper mr --disable 'repo-postman';
# parameters if run on wayland: --enable-features=UseOzonePlatform --ozone-platform=wayland %u

echo -e "\nINSTALL NVM (NODE VERSION MANAGER)";
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash;
nvm install 18.17.1;
nvm alias default 18.17.1;

echo -e "\nINSTALL JET BRAINS MONO FONTS";
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)";

echo -e "\nINSTALL OMZ (OH MY ZSH)";
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended;

echo -e "\nINSTALL OMZ PLUGINS";
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions;
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
git clone https://github.com/lukechilds/zsh-nvm.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm;

echo -e "\nINSTALL ORACLE JDK 8u151";
wget -P ~/Downloads/ --no-check-certificate --no-cookies --header \
"Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm && \
rpm -ivh ~/Downloads/jdk-8u151-linux-x64.rpm;

echo -e "\nINSTALL STS 4";
curl -o ~/Downloads/sts4.tar.gz \
https://download.springsource.com/release/STS4/4.20.0.RELEASE/dist/e4.29/spring-tool-suite-4-4.20.0.RELEASE-e4.29.0-linux.gtk.x86_64.tar.gz && \
tar -xzf ~/Downloads/sts4.tar.gz -C /tmp && \
sudo mv /tmp/sts-4.20.0.RELEASE /opt/ && \
sudo ln -s /opt/sts-4.20.0.RELEASE/SpringToolSuite4 ~/bin/sts;

#echo -e "\nINSTALL KVM"
#sudo zypper install kvm virt-manager libvirt-daemon libvirt-daemon-driver-qemu
#sudo usermod -aG kvm $USER
#sudo usermod -aG libvirt $USER
