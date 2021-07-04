## Nginx Reverse Proxy on Heroku

Here is an example /app/config/nginx.conf.erb for use with the

- [Nginx Buildpack - Github](https://github.com/heroku/heroku-buildpack-nginx)
- [Nginx Buildpack - Heroku](https://elements.heroku.com/buildpacks/heroku/heroku-buildpack-nginx)

* Table
  - [Ver-1](#ver-1)
  - [Ver-2](#ver-2)
  - [And Other](#and-others)

### Ver-1

```conf
daemon off;
# Heroku dynos have at least 4 cores
worker_processes <%= ENV['NGINX_WORKERS'] || 4 %>;

events {
    use epoll;
    accept_mutex on;
    worker_connections <%= ENV['NGINX_WORKER_CONNECTIONS'] || 1024 %>;
}

http {
    gzip on;
    gzip_comp_level 2;
    gzip_min_length 512;
    server_tokens off;

    log_format main '$time_iso8601 - $status $request - client IP: $http_x_forwarded_for - to $upstream_addr - upstream status: $upstream_status, upstream_response_time $upstream_response_time, request_time $request_time';
    access_log /dev/stdout main;
    # set the following to "debug" when diagnosing an issue
    error_log /dev/stdout notice;
    log_not_found on;

    include mime.types;
    default_type application/octet-stream;
    sendfile on;

    # Must read the body in 5 seconds.
    client_body_timeout <%= ENV['NGINX_CLIENT_BODY_TIMEOUT'] || 5 %>;

    # handle SNI
    proxy_ssl_server_name on;
    # resolver needs to be set because we're using dynamic proxy_pass
    resolver 8.8.8.8;

    upstream upstream_app_a {
        server app-a.herokuapp.com:443;
    }

    upstream upstream_app_b {
        server app-b.herokuapp.com:443;
    }

    server {
        listen <%= ENV["PORT"] %>;
        server_name _;

        location / {
            set $upstream upstream_app_a;
            proxy_pass https://$upstream;
            proxy_ssl_name app-a.herokuapp.com;
            proxy_set_header x-forwarded-host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header Host app-a.herokuapp.com;
        }

        location /other {
            set $upstream upstream_app_b;
            proxy_pass https://$upstream;
            proxy_ssl_name app-b.herokuapp.com;
            proxy_set_header x-forwarded-host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header Host app-b.herokuapp.com;
        }
    }
}
```

Source: [Help Heroku](https://help.heroku.com/YTWRHLVH/how-do-i-make-my-nginx-proxy-connect-to-a-heroku-app-behind-heroku-ssl)

### Ver-2

```conf
upstream heroku {
        server myapp.herokuapp.com;
}

server {
        server_name ~^(www\.)(?<domain>.+)$;
        return 301 $scheme://$domain$request_uri;
}

server {
        listen 80 default;
        listen 443 ssl;
        #server_name _;

        ssl off;
        ssl_certificate /etc/nginx/ssl/myapp.com.crt;
        ssl_certificate_key /etc/nginx/ssl/myapp.com.key;

        location ~ \.php$ {
                return 444;
        }

        location / {
                proxy_pass http://heroku;
                proxy_redirect off;
                proxy_read_timeout 5m;
                proxy_set_header Host $http_host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-Proto http;
        }
}
```

### And others

- [Nginx Routing on Heroku](https://greg.nokes.name/2020/02/27/nginx-routing-on-heroku/)
- [Running NGINX on Heroku with Docker](https://ntotten.com/2018/07/22/nginx-on-heroku/)
- [How to Setup Proxy Server for ReactJS and Node on Heroku With Docker](https://valtterilaine.medium.com/how-to-setup-proxy-server-for-reactjs-and-node-on-heroku-with-docker-689e367059d9)

[Back To UP](#nginx-reverse-proxy-on-heroku)
