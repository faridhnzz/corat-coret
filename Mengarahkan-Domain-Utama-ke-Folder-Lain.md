* Mengarahkan Domain Utama ke Folder Lain .htaccess

```
<IfModule mod_rewrite.c>
  RewriteEngine on
  RewriteCond %{HTTP_HOST} ^yuiistic.my.id$ [NC,OR]
  RewriteCond %{HTTP_HOST} ^www.yuiistic.my.id$
  RewriteCond %{REQUEST_URI} !main_doamin/
  RewriteRule (.*) /main_doamin/$1 [L]
</IfModule>
```
