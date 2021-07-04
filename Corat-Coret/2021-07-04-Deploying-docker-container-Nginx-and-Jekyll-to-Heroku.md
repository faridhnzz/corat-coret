### Deploying docker container Nginx and Jekyll to Heroku

Built with Jekyll and Nginx under docker

config Dockerfile

```dockerfile
FROM jekyll/jekyll:3.8.3 as build-stage

ARG PORT

WORKDIR /tmp

COPY Gemfile* ./

RUN bundle install

RUN echo $PORT

WORKDIR /usr/src/app

COPY . .

RUN chown -R jekyll .

RUN jekyll build

FROM nginx:alpine

COPY --from=build-stage /usr/src/app/_site/ /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
```

Config Nginx

```conf
server {
  listen 0.0.0.0:$PORT;

  location / {
    root /usr/share/nginx/html;
    index index.html;
  }
}
```

Source: [Deploying containerized NginX to Heroku - how hard can it be?](https://dev.to/levelupkoodarit/deploying-containerized-nginx-to-heroku-how-hard-can-it-be-3g14)
