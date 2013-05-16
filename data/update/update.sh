mkdir ~/neon-install/
cd ~/neon-install/
wget https://raw.github.com/BlueVM/Neon/develop/neonpanel/includes/configs/nginx.neon.conf
rm -rf /etc/nginx/sites-enabled/nginx.neon.conf 
mv nginx.neon.conf /etc/nginx/sites-enabled/nginx.neon.conf
service nginx reload
