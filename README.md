# Docker SphereServer

Containerized Ulima Online x86 [SphereServer](https://github.com/Sphereserver/Source).

This is a [debian:stretch-slim](https://hub.docker.com/_/debian) with [s6-overlay](https://github.com/just-containers/s6-overlay) based docker image for a highly flexible and configurable SphereServer setup.

For questions and more information about SphereServer, please head to the community [official channels](https://www.sphereserver.com/).

---

## Features

 - Volumes for configuration (scripts, inis and muls) and data (save, accounts and logs)
 - Easy MySQL Setup
 - `spherectl` command tool

## Setup

```
$ git clone https://github.com/miguelpeixe/docker-sphereserver.git
$ cd docker-sphereserver
$ cp env.example .env
```

 - Edit .env with your settings.
 - Place mul files at the `mul/` directory *(required)* and `scripts/` *(optional)* at your env configured `CONFIG` directory:

```
.config/
  scripts/
    spheretables.scp
    ...
  mul/
    hues.mul
    map0.mul
    multi.idx
    multi.mul
    staidx0.mul
    statics0.mul
    tiledata.mul
```

Optionally, you can also provide `sphere.ini` and `sphereCrypt.ini` at the `.config/` directory. If not provided, env generated files will be used.

If `.config/scripts/` directory is empty, [default scripts](https://github.com/Sphereserver/Scripts) will be used.

Data files will be placed at `.data/` directory by default:

```
.data/
  accounts/
  logs/
  save/
```

**Changes in both `.config/` and `.data/` will be applied to the server.**

## Running

Use docker-compose to run your server:

```
$ docker-compose up
```

Keep server running by adding `-d` (detached) option:

```
$ docker-compose up -d
```

The compose file already applies *restart unless stopped* policy.

## Commands

You can send commands to your sphereserver by using `spherectl` command inside docker:

```
$ docker exec [container-id] spherectl account add adminuser adminpassword
$ docker exec [container-id] spherectl account adminuser plevel 7
```
