# Docker Cheatsheet

This cheatsheet included Dockerfile command to build Docker image and ny command to interact with your Docker container for learning purpose and a notes.

# Shortlink

- [Dockerfile](#Dockerfile)
    - [FROM](#from)
    - [LABEL](#label)
    - [ENV](#env)
    - [RUN](#run)
    - [COPY](#copy)
    - [ADD](#add)
- [Docker Command](#docker-command)

## Dockerfile
-------------

### FROM

Which base to use for build Docker image, for example you will use Ubuntu 16.04.

```
FROM ubuntu:16.04
```

To get the base image you can see https://hub.docker.com/explore/, just click what do you want to use and see the documentation.


### LABEL

To adds metadata into your Docker image, like _maintainer_ and _description_ to help organize images by project. 

Using multiple line, you can use :

```
FROM ubuntu:latest

LABEL maintainer="Your Name"
LABEL description="Description of your image"
LABEL com.project.image="Hello Project"
...
...
```

or span multiple line.

```
FROM ubuntu:latest

LABEL maintainer="Your Name" \
      description="Description of your image" \
      com.project.image="Hello Project"
...
...
```

or one-line.

```
FROM ubuntu:16.04

LABEL maintainer="Your Name" description="Description of your image" com.project.image="Hello Project"
...
...
```


After build the image you can see some information the **LABEL** which you set.

```
docker inspect <IMAGE_ID>
```

### ENV

To set values for define environment variable in the image.
```
FROM ubuntu:16.04

ENV PATH /usr/local/bin
...
...
```
or span multiple line.
```
FROM ubuntu:16.04

ENV VAR1="variable 1" \
    VAR2="variable 2"
...
...
```

You can use **ENV** in **RUN** functions.

```
FROM ubuntu:16.04

ENV NGINXPPA="ppa:nginx/stable"

...
RUN add-apt-repository -y $NGINXPPA
...
...
```

### RUN

For executing commmand in container when build the image. For multiple line:

```
FROM ubuntu:16.04

...
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common python-software-properties
...
```

or span multiple line.
```
FROM ubuntu:16.04

...
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common python-software-properties
...
```

### COPY

Instruction to copy local file or directory into the image. This insctruction cannot replace old file with new copied file when build the image, you can use **ADD** to replace old file with the same name.
```
FROM ubuntu:16.04

...
COPY files /home/user/
...
```
And you can set file permission when copied into the image.
```
FROM ubuntu:16.04

...
COPY --chown=user:group files /home/user/
COPY --chown=user:group files /home/user/
...
```

### ADD

Instruction to copy local file or directory, remote file _URLs_, and extract the compress file into the image.
```
FROM ubuntu:16.04

...
ADD files /home/user/
...
```
And you can set file permission when copied into the image.
```
FROM ubuntu:16.04

...
ADD --chown=user:group files /home/user/
...
```

Add file from **URLs**
```
FROM ubuntu:16.04

...
ADD https://example.com/file.txt /home/user/
...
```
Add compress file with extracted it.
```
FROM ubuntu:16.04

...
ADD https://example.com/compress.tar.gz /opt/
...
```

## Docker Command
-------------

| Command           | Description                               |
| ---               | ---                                       |
| *docker images*   | To list available image in local machine  |
| *docker search image* | Search available the image on DockerHub repositories  |
| *docker pull image* | Pull an image from a registry   |
| *docker ps*       | Show all running containers               |
| *docker build -t name:tag .*  | Build the image with spesific name and tag |
| *docker commit <CONTAINER_ID> new_image*    | Create new images from an existing images or running images   |
| *docker run image*      | Run the container image with any options like *-it* for interactive mode  |
| *docker exec image*   | Run a command inside the running container    |
| *docker logs image*   | To display the logs of the image  |
| *docker stop <CONTAINER_ID>* | Stop one or more running containers |
| *docker kill image*   | Kill one or more running containers   |
| *docker pause image* | Pause all process on the spesific containers |
| *docker unpause image* | Unpause all process on the spesific containers   |
| *docker rm*   | Remove one or more images |
| *docker stop $(docker ps -aq)*    | Stop all running containers   |
| *docker rmi $(docker images --filter "dangling=true" -q --no-trunc) --force*  | Remove all untagged images |
| *docker rm $(docker ps -aqf status=exited)*  | Remove an exited containers    |
| *docker rm $(docker ps -aq)*  | Remove all images |


## Refrences

- https://docs.docker.com/engine/reference/commandline/docker/#child-commands
- https://kapeli.com/cheat_sheets/Dockerfile.docset/Contents/Resources/Documents/index
- https://medium.com/the-code-review/top-10-docker-commands-you-cant-live-without-54fb6377f481
