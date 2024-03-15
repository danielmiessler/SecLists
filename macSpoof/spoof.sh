sudo ifconfig wlan0 down
sudo macchanger -r wlan0
sudo ifconfig wlan0 up
echo "-------------------------"
sudo macchanger -s wlan0
