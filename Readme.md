# Docker Image for darts-wled

This repository contains a build script and a Dockerfile to wrap the [darts-wled](https://github.com/lbormann/darts-wled) extension for [Autodarts.io](https://autodarts.io/) into a Docker container.

## Running the container with arguments

To make the configuration of the container as simple and dynamic as possible, the executable arguments got abstracted by environment variables.

Every environment variable starting with `DWLED_` that is present in the container will be added as an argument to the executable upon startup.

_Example:_

In order to set the `-CON` argument, simply add an environment variable `DWLED_CON` to the container. Wrap the values in `"` and leave a space if you want to add multiple values, if supported by the argument, such as:

`DWLED_A4="100-179 ps|22 ps|23"`


## Building the container

The repository contains a build script that creates a multi-platform build for `linux/arm64` and `linux/amd64` for a given relase of [darts-wled](https://github.com/lbormann/darts-wled). The executables are downloaded from GitHub during the build, so ensure that the provided release version is available, e.g. `v1.5.0`

The script automatically publishes the images to a repository, e.g. Docker Hub. Make sure that you are logged in with the Docker CLI and define the appropriate repository / Docker Hub username to push the images.

```./build-docker.sh -v v.1.5.0 -u  <your_docker_hub_user>```





