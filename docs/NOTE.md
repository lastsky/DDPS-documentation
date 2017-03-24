Se http://tcpreplay.appneta.com/wiki/installation.html#simple-directions-for-unix-users

/usr/local/bin/adhoc_update.sh -v

wget https://github.com/appneta/tcpreplay/releases/download/v4.1.1/tcpreplay-4.1.1.tar.gz
sudo apt-get install build-essential libpcap-dev
tar xvfpz tcpreplay-4.1.1.tar.gz 
cd tcpreplay-4.1.1/
./configure 
make
make install
make test
tcpreplay -V
tcpreplay 
cd ..
git clone https://github.com/luigirizzo/netmap.git

mv netmap/ /usr/src

cd /usr/src/netmap; ./configure; make install

En række drivere mangler, hvilket sikkert er noget l***.



sed 's/# deb-src/deb-src/g' /etc/apt/sources.list > /tmp/sources.list
/bin/mv /etc/apt/sources.list /etc/apt/sources.list.org
/bin/mv /tmp/sources.list /etc/apt/sources.list

#####


ZZ
