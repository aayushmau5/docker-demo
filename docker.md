# Essential Docker

## Installation for Arch Linux

Install `docker` and `docker-compose`

```sh
sudo pacman -S docker docker-compose
```

### Enable docker service

```sh
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

### Start docker service

```sh
sudo systemctl start docker.service
sudo systemctl start containerd.service
```

### Add `docker` usergroup

Creating `docker` user-group

```sh
sudo groupadd docker
```

Add `docker` group to your User group

```sh
sudo usermod -aG docker $USER
```

Logout and Login

### Check the installation

Run

```sh
docker info

docker run hello-world
```

### Check versions

```sh
docker --version
docker-compose --version
```

Docker book: [Book](https://www.freecodecamp.org/news/the-docker-handbook)

## Commands

Some docker commands

1. `docker ps -a` - Lists all the containers which are running and which previously ran
2. `docker ps` - Lists all the currently running containers
3. `docker container ls -a` - Lists all the containers which are running and which previously ran
4. `docker container ls` - Lists all the currently running containers

5. `docker run <image-name>` - (Old Syntax) Run a docker image locally
6. `docker container run <image-name>` - (New Syntax) Run a docker image locally
7. `docker container run --publish 8000:80 <image-name>` - Map the host port(8000) with container port(80)
8. `docker container run --detach <image-name>` - Run in the background

9. `docker container run --name <custom-container-name> <image-name>` - Start a container with custom name
10. `docker container rename <container-identifier> <new-name>` - Rename an already running container (Identifier could be the container id or container name)

11. `docker container stop <container-identifier>` - Stop a container
12. `docker container kill <container-identifier>` - Kill a container

13. `docker container start <container-identifier>` - Start any stopped or killed container.(In detached mode as well as retains the previous configs)
14. `docker container restart <container-identifier>` - Restart any running container

`container run` -> `container create` + `container start`

**The container start command starts a container that has been already created**
**The container create command creates a container from a given image**

15. `docker container create --publish 8000:80 <image-name>` - Creates a container from the given image
16. `docker container start <container-identifier>` - Start the container

**Dangling containers** - Containers that have been stopped but remain in the system as cache(May take up space or conflict with other containers)

17. `docker container rm <container-identifier>` - Remove a dangling/stopped container
18. `docker container prune` - Remove all dangling containers
19. `docker container run --rm <image-name>` - `--rm` Remove the container as soon as it is stopped.
20. `docker container start --rm <container-identifier>`

**Interactive images** Like a Linux OS, runs in an interactive shell. These images require a special `-it` option to be passed in the `container run` command.

`-i` -> `--interactive` connects you to the input stream of the container, so that you can send inputs to the bash.
`-t` -> `--tty` a native terminal like experience by allocation a pseudo-tty.

21. `docker container run -it ubuntu` - Run a container in interactive mode.

22. `docker container run <image-name> <command>` - Run a `command` in the container.
    ex. `docker container run arch echo "hello world"`
    Default entry point of the image.
    X executible images

**Executable images** designed to behave like executable programs.
**Bind Mounts** two way file system binding.

23. `docker container run --rm -v <directory-on-filesystem>:<directory-inside-container> <image-name> <command>` - `-v` or `--volume` is used for creating a bind mount for a container.
    Syntax:
    `--volume <local file system directory absolute path>:<container file system directory absolute path>:<read write access>`

The difference between a regular image and an executable one is that the entry-point for an executable image is set to a custom program instead of `sh`, in this case the `rmbyext` program.

**Docker image creation**

A `Dockerfile` is a collection of instruction that, once processed by the daemon, results in an image.

Images are multi-layered files.

Each instructions creates a layer for your image.

24. `docker image build .` - Build an image from the current working directory(must have `Dockerfile` file)

25. `docker image build --tag <image-repository>:<image-tag>` - Tag an image with name.

    `docker image build --tag custom-name:1.0 .`

    Ex. `docker container run mysql:5.7`, here `mysql` is the image repository and `5.7` is the tag.

26. `docker image tag <image-id> <image-respository>:<image-tag>` - Tag an existing image using the image id.

27. `docker image tag <image-repository>:<image-tag> <new-image-repository>:<new-image-tag>` - Change tag of an exisiting image.

28. `docker image ls` - List all the images in your local system.

29. `docker image rm <image-identifier>` - Remove an image.

30. `docker image prune` - Remove all images.

31. `docker image history <image-identifier>` - Visualize the many layers of an image.

32. `docker image pull <image-name>` - Pull a docker image from the registry

33. `docker login` - Login using Dockerhub account

34. `docker image push <image-repository>:<image-tag>` - Push a docker image to docker hub.

35. `docker image build --file <custom-filename> --tag <image-repository>:<tag>` - Use `custom-filename` as our Dockerfile

**Anonymous volumes**

`--volume <container file system directory absolute path>:<read write access>`

`docker container run --rm -p 3000:3000 --name hello --volume $(pwd):/home/node/app --volume /home/node/app/node_modules hello:dev`

**Docker ignore**

`.dockerignore` contains a list of files and directories to be excluded from image builds.

36. `docker container inspect --format='{{range .NetworkSetting.Networks}} {{.IPAddress}} {{end}}' <container-identifier>` - Finding the exact IP address of a container.

**User defined bridge network**

Connecting two containers by putting them under a user-defined bridge network.

**Network** - A network in Docker is another logical object like a container and image.

`docker network` command.

37. `docker network ls` - List out the networks in your system.

**Docker has 5 networking drivers, by default**

bridge, host, none, overlay, macvlan

38. `docker network inspect --format='{{range .Containers}}{{.Name}}{{end}}' bridge` - Inspect the `bridge` network.(See all the containers using the bridge network).

39. `docker network create <network-name>` - Create a user-defined network.

40. `docker network connect <network-identifier> <container-identifier>` - Connect a container to a network.

41. `docker container run --network <network-identifier> <container>` - Another way of connecting to the network.

42. `docker network disconnect <network> <container>` - Disconnect a container from the network.

43. `docker network rm <network>` - Remove a network.

44. `docker volume create <volume-name>` - Create a named volume.

45. `docker volume ls` - List all named volumes.

46. `docker container logs <container>` - See the logs from a particular container.

47. `docker container inspect <container>` - Inspect a docker container.

48. `docker container exec <container-identifier> <command>` - Execute a command inside a running container.

49. `docker container exec -it <container> <command>` - Run a command in interactive mode inside a running container.
    `docker container exec -it container-1 npm run build`

**Docker Compose** for maintaing multi-container projects.

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

Compose is mainly recommended for development and testing. It is not recommended for production.

In the world of Compose, each container that makes up the application is known as a **service**.

Dockercompose uses **docker-compose.yaml** file to read service definitions.

50. `docker-compose --file docker-compose.yaml up --detach` - Start the servies defined in `docker-compose.yaml` file.

51. `docker-compose ps` - List all Service containers started by Compose.
