```
Di bagian server install apache2 "apt-get install apache2" sebagai web servernya.
ubah bagian ports "nano /etc/apache2/ports.conf".
edit bagian "Listen 80 menjadi Listen 1200" habis itu save.
ubah dibagian site-availabe "nano /etc/apache2/site-availabe/000-default.conf".

<VirtualHost *:80> --> Ubah bagian virtual host jadi port 1200

        ServerAdmin webmaster@localhost
		ServeName example.com --> Ubah Sesuai nama domain
        DocumentRoot /var/www/html

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
		
		<Directory /var/www/html>
			AuthName "Login Dulu Sebelum Masuk Website" --> Ubah sesuai keiginan
			AuthType Basic
			AuthFile /etc/apache2/.htpasswd
			Require valid-user
		</Directory>

</VirtualHost>

Habis itu disave.
Buat password untuk masuk di websitenya "htpasswd -c /etc/apache2/.htpasswd (username)"
setelah itu masukan password sesuai keiginan
Habis itu cek config apache "apache2ctl configtest"
Habis itu restart apache "systemctl restart apache2"
setelahitu cek apakan apache sudah running "systemctl status apache2"
Setelah itu dicoba buka di browser
```
