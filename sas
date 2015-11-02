#####################################################################################################
#####################################################################################################
##########################*************Simple Automated Script*************##########################
##########################   d888888o.           .8.            d888888o.  ##########################                                              
########################## .`8888:' `88.        .888.         .`8888:' `88.########################## 
########################## 8.`8888.   Y8       :88888.        8.`8888.   Y8########################## 
########################## `8.`8888.          . `88888.       `8.`8888.    ########################## 
##########################  `8.`8888.        .8. `88888.       `8.`8888.   ########################## 
##########################   `8.`8888.      .8`8. `88888.       `8.`8888.  ########################## 
##########################    `8.`8888.    .8' `8. `88888.       `8.`8888. ########################## 
##########################8b   `8.`8888.  .8'   `8. `88888.  8b   `8.`8888.########################## 
##########################`8b.  ;8.`8888 .888888888. `88888. `8b.  ;8.`8888########################## 
########################## `Y8888P ,88P'.8'       `8. `88888. `Y8888P ,88P'##########################
#####################################################################################################
#####################################################################################################
#####################################################################################################
 
#!/bin/bash
if [ "$(id -u)" != "0" ]; then
echo "This script must be run as root" 1>&2
exit 1
fi
os="";
installer="";
OUTPUT=/etc/openvpn/server.conf;
# ip="ifconfig eth0 | grep -oE '\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b' | head -n1";
# nm="ifconfig eth0 | sed -rn '2s/ .*:(.*)$/\1/p'";
# gw="ip route show default | awk '/default/ {print $3}'";

grep "centos" /etc/os-release -i -q
if [ $? = '0' ];
then
os='CentOS'
echo "$os detected";
installer='yum'
search='yum'
upgrade='upgrade'
fi

grep "debian" /etc/os-release -i -q
if [ $? = '0' ];
then
os='Debian'
echo "$os detected";
installer='apt-get'
search='apt-cache'
upgrade='upgrade'
fi

grep "ubuntu" /etc/os-release -i -q
if [ $? = '0' ];
then
os='Ubuntu'
echo "$os detected";
installer='apt-get'
search='apt-cache'
upgrade='upgrade'
fi

grep "slackware" /etc/os-release -i -q
if [ $? = '0' ];
then
os='Slackware'
echo "$os detected";
installer='slackpkg'
upgrade='upgrade-all'
search='slackpkg'
fi

grep "rogentos" /etc/os-release -i -q
if [ $? = '0' ];
then
os='Rogentos'
echo "$os detected";
installer='equo'
search='equo'
upgrade='upgrade'
search='query files'
fi




if [ $os = "" ];
then
echo "not a valid system os"
exit 1
fi

show_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}You are logged in as: ${NUMBER}`whoami`"
    echo -e "${MENU}Date is: ${NUMBER}`date`"
    echo -e "${MENU}Running ${NUMBER}'$os'"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Packages ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} OpenVPN ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Network restart ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Something ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Something ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Exit ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter. ${NORMAL}"
    read opt

  while [ opt != '' ]
  do
    if [[ $opt = "6" ]]; then 
            exit;
    else
        case $opt in
        1) clear;
        option_picked "Packages";
        show_packages; #Software Updates;
	     show_menu;
        ;;

        2) clear;
            option_picked "OpenVPN"; 
            show_openvpn;
            ;;

        3) clear;
            option_picked "Networking"; 
        sudo ifconfig eth0 down && sudo ifconfig eth0 up; #Network restart;
            show_menu;
            ;;

        4) clear;
            option_picked "Option 4 Picked"; #Something
        ssh something;
            show_menu;
            ;;

	5) clear;
            option_picked "Option 5 Picked"; #Something
        exit;
            ;;

        x)exit;
        ;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi
done
}

option_picked(){
    COLOR="\033[01;31m" # bold red
    RESET="\033[00;00m" # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}

show_openvpn(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}You are logged in as: ${NUMBER}`whoami`"
    echo -e "${MENU}Date is: ${NUMBER}`date`"
    echo -e "${MENU}Running ${NUMBER}'$os'"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} OpenVPN install ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Setup CA ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Copy required files ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Setting up the server ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Something ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Back ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter. ${NORMAL}"
    read subopt
  while [ subopt != '' ]
    do
    if [[ $subopt = "f" ]]; then 
            show_menu;
    else
        case $subopt in
        1) clear;
        option_picked "OpenVPN install";
        sudo $installer install openvpn dnsmasq bridge-utils easy-rsa; #OpenVPN install;
	    show_openvpn;
        ;;

        2) clear;
            option_picked "Setup CA"; 
        sudo vi /etc/openvpn/easy-rsa/vars; #Setup CA;
            show_openvpn;
            ;;

        3) clear;
            option_picked "Copy required files"; 
            sudo mkdir /etc/openvpn/easy-rsa/; #Copy required files;
            sleep 2
	    sudo cp -R /usr/share/easy-rsa/* /etc/openvpn/easy-rsa/;
            sleep 2
            cd /etc/openvpn/easy-rsa/; ## move to the easy-rsa directory
            sleep 2
            sudo chmod g+w . ## make this directory writable by the system administrators
            sleep 2
            source ./vars ## execute your new vars file
            sleep 2
            ./clean-all;  ## Setup the easy-rsa directory (Deletes all keys)
            sleep 2
            ./build-dh;  ## takes a while consider backgrounding
            sleep 2
            ./pkitool --initca; ## creates ca cert and key
            sleep 2
            ./pkitool --server server; ## creates a server cert and key
            sleep 2
            cd keys;
            sleep 2
            openvpn --genkey --secret ta.key;  ## Build a TLS key
            sleep 2
            sudo cp server.crt server.key ca.crt dh2048.pem ta.key ../../; 		
	    show_openvpn;
            ;;

        4) clear;
            option_picked "Setting up the server - bridged"; 
            cd /etc/openvpn/;
            sudo echo "#!/bin/sh" > up.sh;
            sudo echo " " >> up.sh;
            sudo echo 'BR=$1' >> up.sh;
            sudo echo 'DEV=$2' >> up.sh;
            sudo echo 'MTU=$3' >> up.sh;
            sudo echo '/sbin/ip link set "$DEV" up promisc on mtu "$MTU"' >> up.sh;
            sudo echo '/sbin/brctl addif $BR $DEV' >> up.sh;
	    sudo echo "#!/bin/sh" > down.sh;
            sudo echo " " >> down.sh;
            sudo echo 'BR=$1' >> down.sh;
            sudo echo 'DEV=$2' >> down.sh;
            sudo echo " " >> down.sh;
            sudo echo '/sbin/brctl delif $BR $DEV' >> down.sh;
            sudo echo '/sbin/ip link set "$DEV" down' >> down.sh;
            sudo chmod +x /etc/openvpn/up.sh /etc/openvpn/down.sh;
            sudo echo 'mode server' >> $OUTPUT;
            sudo echo 'tls-server'>> $OUTPUT;
            sudo echo 'dev tap0' >> $OUTPUT;
            sudo echo 'up "/etc/openvpn/up.sh br0 tap0 1500"' >> $OUTPUT;
            sudo echo 'down "/etc/openvpn/down.sh br0 tap0"' >> $OUTPUT;
            sudo echo 'persist-key' >> $OUTPUT;
            sudo echo 'persist-tun' >> $OUTPUT;
            sudo echo 'ca ca.crt' >> $OUTPUT;
            sudo echo 'cert server.crt' >> $OUTPUT;
            sudo echo 'key server.key' >> $OUTPUT;
            sudo echo 'dh dh1024.pem' >> $OUTPUT;
            sudo echo 'tls-auth ta.key 0' >> $OUTPUT;
            sudo echo 'cipher BF-CBC' >> $OUTPUT;
            sudo echo 'comp-lzo' >> $OUTPUT;
            sudo echo 'max-clients 10' >> $OUTPUT;
            sudo echo 'ifconfig-pool-persist ipp.txt' >> $OUTPUT;
            sudo echo 'user nobody' >> $OUTPUT;
            sudo echo 'group nogroup' >> $OUTPUT;
            sudo echo 'keepalive 10 120' >> $OUTPUT;
            sudo echo 'status openvpn-status.log' >> $OUTPUT;
            sudo echo 'verb 3'
            sudo echo "Type in the IP address of your server (default: 192.168.1.1):";
                     ip=""
                     read ip && echo local "$ip" >> $OUTPUT;
	    sudo echo "Choose openvpn port (default: 1194):";
                     port=""
                     read port && echo port "$port" >> $OUTPUT;
	    sudo echo "Select transfer protocol, tcp/udp (default: tcp)";
                     proto=""
                     read proto && echo proto "$proto" >> $OUTPUT;
	    sudo echo "Type in the server bridge address and client pool list"
	    sudo echo "Default: 192.168.1.10 255.255.255.0 192.168.1.100 192.168.1.110"
		     bridge=""
		     read bridge && echo server-bridge "$bridge" >> $OUTPUT;
	    sudo echo "Setup push primary DNS settings to clients"
	    sudo echo "Type in the primary DNS address"
		     dns=""
		     read dns && echo push "dhcp-option DNS "$dns"" >> $OUTPUT;
	    sudo echo "Setup push secondary DNS settings to clients"
	    sudo echo "Type in the secondary DNS address"
		     dns=""
		     read dns && echo push "dhcp-option DNS "$dns"" >> $OUTPUT;
	    sudo echo "Setup push DOMAIN settings to clients"
	    sudo echo "Type in the DOMAIN name"
		     domain=""
		     read domain && echo push "dhcp-option DOMAIN "$domain"" >> $OUTPUT;
            show_openvpn;
            ;;

        5) clear;
            option_picked "Setting up the server - tunnel"; #Coming soon
        ssh something;
            show_openvpn;
            ;;

	6) clear;
            option_picked "Back to main menu"; #Back
            show_menu;
            ;;

        x)exit;
        ;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_openvpn;
        ;;
    esac
fi
done
}

show_packages(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}You are logged in as: ${NUMBER}`whoami`"
    echo -e "${MENU}Date is: ${NUMBER}`date`"
    echo -e "${MENU}Running ${NUMBER}'$os'"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Package update ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Package upgrade ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Package search ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Package install ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Package remove ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Package - list files ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 7)${MENU} Back ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter. ${NORMAL}"
    read subpack
  while [ subpack != '' ]
    do
    if [[ $subpack = "7" ]]; then 
            show_menu;
    else
        case $subpack in
        1) clear;
        option_picked "Package update";
        $installer update;
        show_packages;
	;;

        2) clear;
        option_picked "Package upgrade";
        $installer $upgrade;
        show_packages;
	;;

        3) clear;
        option_picked "Package search";
        echo "Type in the package name you want to search:";
            read pack && $search search $pack;
        show_packages;
	;;

        4) clear;
        option_picked "Package install";
        echo "Type in the package name you want to install:";
            read pack && $installer install $pack;
        show_packages;
	;;

        5) clear;
        option_picked "Package remove";
        echo "Type in the package name you want to uninstall:";
            read pack && $installer remove $pack;
        show_packages;
	;;

        6) clear;
        option_picked "Package - list files";
        echo "Type in the package file you want to list file contents";
            if [ -n "$(grep "Rogentos" /etc/os-release -i)" ];
			then
			read pack && $installer query files $pack;
			elif [ -n "$(grep "CentOS" /etc/os-release -i)" ];
			then
			read pack && rpm -ql $pack;
			else
			read pack && dpkg --listfiles $pack;
		fi	
        show_packages;
        ;;

        7) clear;
        option_picked "Back";
        show_menu;
	;;

        x)exit;
        ;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_packages;
        ;;
    esac
fi
done
}

clear
show_menu
