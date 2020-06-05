
#----------------------
sudo apt-get install -y gcc make libpcre3-dev zlib1g-dev libluajit-5.1-dev libpcap-dev openssl libssl-dev libnghttp2-dev libdumbnet-dev bison flex libdnet
mkdir ~/snort_src && cd ~/snort_src
wget https://snort.org/downloads/snort/daq-2.0.6.tar.gz                   
wget https://snort.org/downloads/snort/snort-2.9.15.1.tar.gz
tar xvzf daq-2.0.6.tar.gz              
cd daq-2.0.6
./configure && make && sudo make install
cd ..
ls
tar xvzf snort-2.9.15.1.tar.gz                  
cd snort-2.9.15.1
sudo apt-get update -y
sudo apt-get install -y luajit
./configure --enable-sourcefire --disable-open-appid && make && sudo make install
#--------------


echo Now configuring snort to run in NIDS mode
Sudo ldconfig
sudo ln -s /usr/local/bin/snort /usr/sbin/snort
sudo groupadd snort
sudo useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort
sudo mkdir -p /etc/snort/rules
sudo mkdir /var/log/snort
sudo mkdir /usr/local/lib/snort_dynamicrules

echo setting permissions
sudo chmod -R 5775 /etc/snort
sudo chmod -R 5775 /var/log/snort
sudo chmod -R 5775 /usr/local/lib/snort_dynamicrules
sudo chown -R snort:snort /etc/snort
sudo chown -R snort:snort /var/log/snort
sudo chown -R snort:snort /usr/local/lib/snort_dynamicrules
sudo touch /etc/snort/rules/white_list.rules
sudo touch /etc/snort/rules/black_list.rules
sudo touch /etc/snort/rules/local.rules
sudo cp ~/snort_src/snort-2.9.15.1/etc/*.conf* /etc/snort
sudo cp ~/snort_src/snort-2.9.12/etc/*.map /etc/snort
wget https://www.snort.org/rules/community -O ~/community.tar.gz
sudo tar -xvf ~/community.tar.gz -C ~/
sudo cp ~/community-rules/* /etc/snort/rules
echo configuring network and rule sets

echo validating settings
sudo snort -T -c /etc/snort/snort.conf
echo Testing the configuration 
sleep 5

echo Now writing a rule
#sudo nano /etc/snort/rules/local.rules
$file = /etc/snort/rules/local.rules
echo “alert icmp any any -> $HOME_NET any (msg:"ICMP test"; sid:10000001; rev:001;)” > $file
sudo snort -A console -i wlan0 -u snort -g snort -c /etc/snort/snort.conf
ip addr
snort -r /var/log/snort/snort.log.

#sudo nano /lib/systemd/system/snort.service
file = /lib/systemd/system/snort.service
echo “[Unit]” > file
echo “Description=Snort NIDS Daemon” > file
echo “After=syslog.target network.target” > file
echo “” > file
echo “[Service]” > file
echo “Type=simple” > file
Echo “ExecStart=/usr/local/bin/snort -q -u snort -g snort -c /etc/snort/snort.conf -i eth0” > file
echo “” > file
echo “[Install]” > file
echo “WantedBy=multi-users.target” > file

echo Now running snort in the background
sudo systemctl daemon-reload
sudo systemctl start snort
sudo systemctl status snort

wget https://github.com/mattymcfatty/HoneyPi/archive/master.zip
unzip master.zip
cd HoneyPi-master
chmod +x *.sh
sudo ./honeyPiInstaller.sh
