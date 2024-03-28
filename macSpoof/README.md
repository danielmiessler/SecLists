# macSpoof
Spoof your mac address.

Getting started,

git clone https://github.com/Mad-man-8/macSpoof.git

cd macSpoof

bash spoof.sh

The name of your wireless interface is most probably wlan0. If it isn't wlan0, open the spoof.sh file with nano and replace 'wlan0' with the name of your wireless interface. If you don't know your wireless interface's name, you can check it with the command,

sudo lshw -c network

in front of 'logical name:' you'll see your wireless interface's name.

