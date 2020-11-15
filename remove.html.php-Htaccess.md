Edit file .htaccess 
ganti dengan script berikut

* HTML
```
<IfModule mod_rewrite.c>
RewriteEngine on
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{REQUEST_FILENAME}.html !-f
RewriteRule ^(.*)$ $1.html
</IfModule>
```

* PHP
```
<IfModule mod_rewrite.c>
RewriteEngine on
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{REQUEST_FILENAME}.php -f
RewriteRule ^(.*)$ $1.php
</IfModule>
```

Source : [Domainesia](https://www.domainesia.com/panduan/cara-menghapus-ekstensi-html-melalui-htaccess) | [phpmu(dot)com](https://www.members.phpmu.com/forum/read/bagaimana-cara-membuat-website-tanpa-url-php-ataupun-html)
