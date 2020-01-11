#!/bin/bash
echo "Select an SDK or tool to install:"

# Operating system names are used here as a data source
select program in \
    NodeJS \
    Python-3 \
    Java \
    Ruby \
    C# \
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
    Docker; do

    case $program in
    # Two case values are declared here for matching
    "Docker")
        sudo curl -fsSL https://get.docker.com/ | sh
        echo "Would you like to access docker as non-root user?"
        select $option in yes or no; do
        sudo usermod -aG docker "$user"
        echo "User can now access docker as non-root. You must reboot computer for the changes to take effect."
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
    esac
done
