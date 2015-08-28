# Shopping Scenario with Docker

## Dependencies
* Read access to the [Shopping Scenario repo](https://github.com/code-iai/shopping_scenario).
* [SSH access to GitHub](https://help.github.com/articles/generating-ssh-keys/)
* [Docker](http://docs.docker.com/linux/started/)

## Build image
Run the `./build.sh` script. After cloning some GitHub repositories it will ask for your SU password.

```shell
$ ./build.sh
```

## Run the image
```shell
$ ./run.sh
```

This will run the `shopping_scenario` docker image with some additional flags in order to expose the GUI to the host.
