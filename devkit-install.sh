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
    SQL \
    FORTRAN \
    Ada \
    Pascal \
    BASIC \
    PHP \
    Objective-C \
    Docker \
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
        sudo apt-get install apt-transport-https
        sudo apt-get update
        sudo apt-get install dotnet-sdk-3.1

        # ASP.NET Core runtime
        sudo apt-get update
        sudo apt-get install apt-transport-https
        sudo apt-get update
        sudo apt-get install aspnetcore-runtime-3.1

        # .NET Core runtime
        sudo apt-get update
        sudo apt-get install apt-transport-https
        sudo apt-get update
        sudo apt-get install dotnet-runtime-3.1
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
                sudo apt install openjdk-8-jdk
                ;;
            "9")
                sudo apt install openjdk-9-jdk
                ;;
            "10")
                sudo apt install openjdk-10-jdk
                ;;
            "11")
                sudo apt install openjdk-11-jdk
                ;;
            "12")
                sudo apt install openjdk-12-jdk
                ;;
            "13")
                sudo apt install openjdk-13-jdk
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
        sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn

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
        ;;

    "C++")
        echo "Installing C++"
        ;;

    "Perl")
        echo "Installing Perl"
        ;;

    "FORTRAN")
        echo "Installing FORTRAN"
        ;;

    "Ada")
        echo "Installing Ada"
        ;;

    "Pascal")
        echo "Installing Pascal"
        ;;

    "BASIC")
        echo "Installing BASIC"
        ;;

    "Objective-C")
        echo "Installing Objective C"
        ;;

    "SQL")
        echo "Installing SQL"
        ;;

    "Exit")
        break
        ;;

    esac
done
