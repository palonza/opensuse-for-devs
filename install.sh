#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "Error: This script must be executed as root. Please, use sudo.";
    exit 1;
fi

if [ -z "$1" ]; then
    echo "Error: You must provide your user name.";
    exit 1;
fi

echo -e "\nUPDATE OPENSUSE";
# add this param to end next line: -y --auto-agree-with-licenses?
zypper refresh && zypper update -y --auto-agree-with-licenses;

echo -e "\nUNINSTALL DEFAULT APPLICATIONS";
zypper remove -y --clean-deps marble kmines kmahjongg \
kpat kreversi ksudoku kontact hugin kmail ktnef xscreensaver \
akregator skanlite korganizer pim-sieve-editor \
pim-data-exporter akonadi-calendar-tools akonadi-contact \
akonadi-import-wizard akonadi-plugin-calendar \
akonadi-plugin-contacts akonadi-plugin-contacts \
akonadi-plugin-contacts akonadi-plugin-contacts xterm \
mariadb mailcommon mailimporter xscreensaver akonadi-calendar-tools akonadi-contacts akonadi-import-wizard akonadi-mime akonadi-plugin-calendar akonadi-plugin-contacts libKPim6AkonadiAgentBase6 libKPim6AkonadiContactCore6 libKPim6AkonadiContactWidgets6 libKPim6AkonadiCore6 libKPim6AkonadiMime6 libKPim6AkonadiNotes6 libKPim6AkonadiPrivate6 libKPim6AkonadiSearch6 libKPim6AkonadiWidgets6 libKPim6PimCommonAkonadi6;

echo -e "\nLOCKING UNINSTALLED AND UNNUSED PACKAGES";
zypper addlock marble kmines kmahjongg \
kpat kreversi ksudoku kontact hugin kmail ktnef xscreensaver \
akregator skanlite korganizer pim-sieve-editor \
pim-data-exporter akonadi-calendar-tools akonadi-contact \
akonadi-import-wizard akonadi-plugin-calendar \
akonadi-plugin-contacts akonadi-plugin-contacts \
akonadi-plugin-contacts akonadi-plugin-contacts xterm \
mariadb mailcommon mailimporter xscreensaver partitionmanager akonadi-calendar-tools akonadi-contacts akonadi-import-wizard akonadi-mime akonadi-plugin-calendar akonadi-plugin-contacts libKPim6AkonadiAgentBase6 libKPim6AkonadiContactCore6 libKPim6AkonadiContactWidgets6 libKPim6AkonadiCore6 libKPim6AkonadiMime6 libKPim6AkonadiNotes6 libKPim6AkonadiPrivate6 libKPim6AkonadiSearch6 libKPim6AkonadiWidgets6 libKPim6PimCommonAkonadi6;
 
echo -e "\nINSTALL ZSH (please, restart.)";
zypper install -y --auto-agree-with-licenses zsh;
#chsh -s $(which zsh);

echo -e "\nINSTALL UTILITIES";#ksysguard5 xournalpp no es compatible con kde plasma 6
zypper install -y --auto-agree-with-licenses neofetch helvum symbols-only-nerd-fonts findutils-locate libnotify-tools libqt5-qtbase-devel \
mariadb-client sensors xclip btop powerline-fonts ksystemlog bucklespring gimp kwrite wireshark qt6-multimedia \
inkscape java-11-openjdk eclipse-jdt dconf-editor protonvpn-gui simplescreenrecorder kio-gdrive xdotool qemu-guest-agent;

#TODO: agregar esto
#zypper addrepo https://download.opensuse.org/repositories/home:hennevogel:modern-unix/openSUSE_Tumbleweed/home:hennevogel:modern-unix.repo && \
#sudo zypper refresh && sudo zypper install exa

sudo updatedb;
 
# zypper --gpg-auto-import-keys --non-interactive --quiet ar -n 'repo-ruby' \
# -f https://download.opensuse.org/repositories/home:bmwiedemann:ruby/dlre_Tumbleweed/home:bmwiedemann:ruby.repo && \
# zypper --gpg-auto-import-keys ref && zypper install -y --auto-agree-with-licenses ruby3.2-rubygem-lolcat && \
# zypper mr --disable 'repo-ruby';
# gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

echo -e "\nINSTALL GOOGLE CHROME";
#echo -e "[chrome]\nenabled=1\nautorefresh=1\nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64\ntype=rpm-md\npriority=100\ngpgcheck=1\ngpgkey=https://dl.google.com/linux/linux_signing_key.pub\n" > /etc/zypp/repos.d/repo-chrome.repo && \
#wget -P ~/Downloads/linux_signing_key.pub https://dl.google.com/linux/linux_signing_key.pub && \
#rpm --import ~/Downloads/linux_signing_key.pub && zypper refresh && zypper install -y --auto-agree-with-licenses google-chrome-stable;

#sudo -u $1 wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub > /home/$1/Downloads/linux_signing_key.pub && \
#sudo -u $1 rpm --import /home/$1/Downloads/linux_signing_key.pub && \
#zypper --gpg-auto-import-keys --non-interactive --quiet ar -n 'repo-chrome' \
#-f http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome && zypper --gpg-auto-import-keys ref && \
#zypper install -y --auto-agree-with-licenses google-chrome-stable;

echo "[chrome]
enabled=1
autorefresh=1
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
type=rpm-md
priority=100
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub" | tee /etc/zypp/repos.d/repo-chrome.repo
zypper install google-chrome-stable

echo -e "\nINSTALL VSCODE";
rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
zypper --gpg-auto-import-keys --non-interactive --quiet ar -n 'repo-code' -f https://packages.microsoft.com/yumrepos/vscode vscode && \
zypper --gpg-auto-import-keys ref && zypper install -y --auto-agree-with-licenses code;

echo -e "\nINSTALL DOT NET SDK 8";
zypper install -y --auto-agree-with-licenses libicu && \
sudo -u $1 wget -P /home/$1/Downloads/ https://packages.microsoft.com/config/opensuse/15/prod.repo && \
mv /home/$1/Downloads/prod.repo /etc/zypp/repos.d/microsoft-prod.repo && \
chown root:root /etc/zypp/repos.d/microsoft-prod.repo && \
zypper --gpg-auto-import-keys ref && zypper install -y --auto-agree-with-licenses dotnet-sdk-8.0;

echo -e "\nINSTALL DBEAVER";
zypper --gpg-auto-import-keys --non-interactive --quiet ar -n 'repo-dbeaver' \
-f https://download.opensuse.org/repositories/home:cabelo:innovators/openSUSE_Tumbleweed/home:cabelo:innovators.repo && \
zypper --gpg-auto-import-keys ref && zypper install -y --auto-agree-with-licenses dbeaver && \
zypper mr --disable 'repo-dbeaver';

echo -e "\nINSTALL WAVEBOX";
sudo -u $1 curl -sSL https://download.wavebox.app/static/wavebox_repo.key | gpg --import && \
wget -P /etc/zypp/repos.d/ https://download.wavebox.app/stable/linux/rpm/wavebox.repo && \
zypper --gpg-auto-import-keys --non-interactive --quiet mr 'Wavebox - x86_64' && \
zypper --gpg-auto-import-keys ref && zypper install -y --auto-agree-with-licenses Wavebox;

echo -e "\nINSTALL DOCKER";
zypper install -y --auto-agree-with-licenses docker docker-compose yast2-docker && usermod -aG docker $1;

# TODO: note: here request always required (CHANGE THIS)
echo -e "\nINSTALL POSTMAN"; 
zypper --gpg-auto-import-keys --non-interactive --quiet ar -n 'repo-postman' \
-f https://download.opensuse.org/repositories/home:gmsh/openSUSE_Tumbleweed/home:gmsh.repo && \
zypper --gpg-auto-import-keys --non-interactive --quiet mr 'repo-postman' && \
zypper --gpg-auto-import-keys ref && zypper install -y --auto-agree-with-licenses postman && \
zypper mr --disable 'repo-postman' && zypper refresh;

# parameters if run on wayland: --enable-features=UseOzonePlatform --ozone-platform=wayland %u

sudo -u $1 gem install lolcat --user-install && \
sudo -u $1 ln -s /home/$1/.local/share/gem/ruby/3.3.0/bin/lolcat.ruby3.3 /home/$1/bin/lolcat;

# el siguiente comando posiblemente deba ejecutarse con sudo -u $USER o sudo -u $polook-suse, PROBARLO!!
echo -e "\nINSTALL NVM (NODE VERSION MANAGER)";
sudo -u $1 curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | sudo -u $1 bash;
sudo -u $1 nvm install 18.17.1;
sudo -u $1 nvm alias default 18.17.1;

echo -e "\nINSTALL JET BRAINS MONO FONTS";
sudo -u $1 /bin/bash -c "$(sudo -u $1 curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)";

echo -e "\nINSTALL OMZ (OH MY ZSH)";
# el siguiente comando deberia ejecutarse sin sudo
sudo -u $1 sh -c "$(sudo -u $1 curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended;
sudo -u $1 zsh -c "zstyle ':omz:update' mode auto";
sudo -u $1 zsh -c "omz update";
sudo -u $1 zsh -c "source /home/$1/.zshrc";

echo -e "\nINSTALL OMZ PLUGINS";
# sudo -u $1 mkdir ~/.oh-my-zsh/;
# sudo -u $1 mkdir ${ZSH_CUSTOM:-~/.oh-my-zsh/custom};
sudo -u $1 git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$1/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting;
sudo -u $1 git clone https://github.com/zsh-users/zsh-completions.git /home/$1/.oh-my-zsh/custom/plugins/zsh-completions;
sudo -u $1 git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/$1/.oh-my-zsh/custom/plugins/zsh-autosuggestions;
sudo -u $1 git clone https://github.com/lukechilds/zsh-nvm.git /home/$1/.oh-my-zsh/custom/plugins/zsh-nvm;

echo -e "\nINSTALL ORACLE JDK 8u151";
#wget -P ~/Downloads/ --continue --no-check-certificate --no-cookies --header \
#"Cookie: oraclelicense=accept-securebackup-cookie" \
#http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm && \
#rpm -ivh ~/Downloads/jdk-8u151-linux-x64.rpm;

sudo -u $1 wget --content-disposition \
"https://javadl.oracle.com/webapps/download/AutoDL?BundleId=239835_230deb18db3e4014bb8e3e8324f81b43" \
-P /home/$1/Downloads/ -O jdk-8u221.tar.gz && \
sudo -u $1 tar -xzvf /home/$1/Downloads/jdk-8u221.tar.gz -C /tmp && \
mv /tmp/jdk1.8.0_221 /usr/lib64/jvm/;

echo -e "\nINSTALL STS 4";
sudo -u $1 curl -o /home/$1/Downloads/sts4.tar.gz \
https://download.springsource.com/release/STS4/4.20.0.RELEASE/dist/e4.29/spring-tool-suite-4-4.20.0.RELEASE-e4.29.0-linux.gtk.x86_64.tar.gz && \
sudo -u $1 tar -xzf /home/$1/Downloads/sts4.tar.gz -C /tmp && \
mv /tmp/sts-4.20.0.RELEASE /opt/ && \
sudo -u $1 ln -s /opt/sts-4.20.0.RELEASE/SpringToolSuite4 /home/$1/bin/sts;

# echo -e "\nINSTALL TOR BROWSER";
# sudo -u $1 curl -o /home/$1/Downloads/tor-expert-bundle-linux-x86_64-13.0.9.tar.gz \
# https://archive.torproject.org/tor-package-archive/torbrowser/13.0.9/tor-expert-bundle-linux-x86_64-13.0.9.tar.gz && \
# sudo -u $1 tar -xzf /home/$1/Downloads/tor-expert-bundle-linux-x86_64-13.0.9.tar.gz -C /tmp && \
# mv /tmp/tor /opt/ && \
# sudo -u $1 ln -s /opt/tor/tor /home/$1/bin/tor;

#echo -e "\nINSTALL KVM (Please, close this sesion, when finish.)"
#zypper install kvm virt-manager libvirt-daemon libvirt-daemon-driver-qemu
#usermod -aG kvm $1
#usermod -aG libvirt $1
#usermod -aG qemu $1
echo -e "\nPlease, restart this computer to refresh new settings.";

sudo updatedb;
