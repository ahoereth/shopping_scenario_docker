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
The build script creates a Docker image named `shopping_scenario` - run it.

```shell
$ docker run shopping_scenario
```

The default commands executed when running the image:
```
$ roslaunch shopping_scenario_executive shopping_scenario.launch&
$ roslaunch shopping_scenario_executive shopping_scenario_simulation.launch
```
