# Activate batman-adv
sudo modprobe batman-adv
# Disable and configure wlan0
sudo ip link set wlan0 down
sudo ifconfig wlan0 mtu 1500 #if you have another wifi interface you may use a higher mtu
sudo iwconfig wlan0 mode ibss 
#most devices support ibss rather than ad-hoc, if you have a device that can support ad-hoc mode you can use it
sudo iwconfig wlan0 essid my-mesh-network
sudo iwconfig wlan0 ap any
sudo iwconfig wlan0 channel 8
sudo ip link set wlan0 up
sudo batctl if add wlan0
sudo ifconfig bat0 up
sleep 5s
sudo ifconfig bat0 172.27.0.1/16 # Use different IPv4 addresses for each device

#note: dhcp can be used instead to automatically assign ipv4/6 addresses 
#if that is the case use sudo avahi-autoipd bat0
#make sure to have another interface that can be used for uplink to a router to ensure nodes on the network have internet access
#ibss doesn't really support bridging as it is an independent service 
#however since batman-adv runs on layer 2 it can be used to bridge non batman devices to the network as well

#ip link add name mesh-bridge type bridge
#ip link set dev eth0/wlan1 master mesh-bridge
#ip link set dev bat0 master mesh-bridge
#ip link set up dev eth0/wlan1
#ip link set up dev bat0
#ip link set up dev mesh-bridge

#ensure to select either ethernet or the network adapter to allow exchange of packets between the internet and the mesh network
#uncomment the ip link commands if you want to set up a bridge, make sure to get rid of the interface you don't want to use, e.g.wlan1 or eth0
