#!/bin/bash
echo "Select an SDK or tool to install:"

# Operating system names are used here as a data source
select program in \
    NodeJS \
    Python-3 \
    Java \
    Ruby \
    .NET-Core \
    C \
    C++ \
    Perl \
    mySQL \
    FORTRAN \
    Ada \
    Pascal \
    PHP \
    Objective-C \
    Docker \
    PostgreSQL \
    Exit; do

    case $program in
    # Two case values are declared here for matching
    "Docker")
        sudo curl -fsSL https://get.docker.com/ | sh
        echo "Would you like to access docker as non-root user?"
        select option in yes or no; do
            case $option in
            "yes")
                sudo usermod -aG docker "$user"
                echo "User can now access docker as non-root. You must reboot computer for the changes to take effect."
                ;;
            "no")
                echo ""
                ;;
            esac
        done
        ;;

    "NodeJS")
        echo "Which version?"
        select version in 8 10 11 12 13; do
            case $version in
            "8")
                echo "Installing Node v8"
                curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
                sudo apt-get install -y nodejs
                ;;
            "10")
                echo "Installing Node v10"
                curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
                sudo apt-get install -y nodejs
                ;;
            "11")
                echo "Installing Node v11"
                curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
                sudo apt-get install -y nodejs
                ;;
            "12")
                echo "Installing Node v12"
                curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
                sudo apt-get install -y nodejs
                ;;
            "13")
                echo "Installing Node v13"
                curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
                sudo apt-get install -y nodejs
                ;;
            esac
        done
        ;;

    ".NET-Core")
        echo "Installing .NET Core SDK"
        # Register microsoft key and feed
        wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb

        # .NET core SDK
        sudo apt-get update
        sudo apt-get install apt-transport-https -y
        sudo apt-get update
        sudo apt-get install dotnet-sdk-3.1 -y

        # ASP.NET Core runtime
        sudo apt-get update
        sudo apt-get install apt-transport-https -y
        sudo apt-get update
        sudo apt-get install aspnetcore-runtime-3.1 -y

        # .NET Core runtime
        sudo apt-get update
        sudo apt-get install apt-transport-https -y
        sudo apt-get update
        sudo apt-get install dotnet-runtime-3.1 -y
        ;;

    "Python-3")
        echo "Installing latest version of Python 3"
        sudo apt update
        sudo apt install software-properties-common
        echo "Set default python version to latest version?"
        select option in yes no; do
            case $option in
            "yes")
                sudo update-alternatives --set python /usr/bin/python3.8
                ;;
            esac
        done
        ;;

    "Java")
        echo "Which JDK version?"
        select option in 8 9 10 11 12 13; do
            case $option in
            "8")
                sudo apt install openjdk-8-jdk -y
                ;;
            "9")
                sudo apt install openjdk-9-jdk -y
                ;;
            "10")
                sudo apt install openjdk-10-jdk -y
                ;;
            "11")
                sudo apt install openjdk-11-jdk -y
                ;;
            "12")
                sudo apt install openjdk-12-jdk -y
                ;;
            "13")
                sudo apt install openjdk-13-jdk -y
                ;;
            esac
        done
        echo "Change default version with 'sudo update-alternatives --config java'"
        echo "Set environment variable 'JAVA_HOME=pathtojava' >> 'sudo nano /etc/environment'"
        ;;

    "Ruby")
        echo "Installing Ruby"

        # Installing dependencies for Ruby and Rails
        sudo apt install curl
        curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

        sudo apt-get update
        sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn -y

        # Install ruby with rbenv
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >>~/.bashrc
        echo 'eval "$(rbenv init -)"' >>~/.bashrc
        exec $SHELL

        git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
        echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >>~/.bashrc
        exec $SHELL

        rbenv install 2.7.0
        rbenv global 2.7.0
        ruby -v
        gem install bundler

        # Install Rails
        gem install rails -v 6.0.2.1
        rbenv rehash
        rails -v

        # More info https://gorails.com/setup/
        ;;

    "C")
        echo "Installing C"
        sudo apt update
        sudo apt install build-essential -y  # installs gcc, g++ and make
        sudo apt-get install manpages-dev -y # installs the manual for GNU/Linux
        ;;

    "C++")
        echo "Installing C++"
        sudo apt install g++ -y
        sudo apt install build-essential -y
        ;;

    "Perl")
        echo "Installing Perl"
        apt-get install -y perl
        ;;

    "FORTRAN")
        echo "Installing FORTRAN"
        sudo add-apt-repository ppa:ubuntu-toolchain-r/test
        sudo apt update
        sudo apt install gfortran-9 -y
        gfortran-9 --version
        ;;

    "Ada")
        echo "Installing Ada"
        apt-get install gnat-4.3 -y
        apt-get install gnat-gps -y
        ;;

    "Pascal")
        echo "Installing Pascal"
        sudo apt-get install lazarus-ide -y
        gpg --keyserver hkp://pgp.mit.edu:11371 --recv-keys 6A11800F
        gpg -a --export 6A11800F | sudo apt-key add -
        echo "deb http://www.hu.freepascal.org/lazarus/ lazarus-stable universe" | sudo tee /etc/apt/sources.list.d/lazarus-stable.list
        sudo apt-get update
        sudo apt-get install lazarus -y
        ;;

    "Objective-C")
        echo "Installing Objective C (gobjc)"
        sudo apt-get install gobjc++ -y
        ;;

    "PHP")
        echo "Installing PHP"
        sudo apt-get install php libapache2-mod-php
        ;;

    "mySQL")
        echo "Installing mySQL"
        sudo apt-get update
        sudo apt-get install mysql-server
        sudo mysql_secure_installation utility
        sudo systemctl start mysql
        sudo systemctl enable mysql # start on boot
        echo "Start mysql shell with 'mysql -u root'"
        ;;
    
    "PostgreSQL")
        sudo apt-get install postgresql postgresql-contrib
        sudo update-rc.d postgresql enable # start on boot
        sudo service postgresql start
        echo "Switch to root user, 'su - postgres' & 'psql'"
        ;;

    "Exit")
        break
        ;;

    esac
done
