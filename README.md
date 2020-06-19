# Docker SphereServer

Containerized Ulima Online [SphereServer 0.56d](https://github.com/Sphereserver/Source).

This is a [debian:stretch-slim](https://hub.docker.com/_/debian) with [s6-overlay](https://github.com/just-containers/s6-overlay) based docker image for a highly flexible and configurable SphereServer setup.

For questions and more information about SphereServer, please head to the community [official channels](https://www.sphereserver.com/).

---

## Features

- Volumes for configuration (scripts, inis and muls) and data (save, accounts and logs)
- Backups
- `spherectl` command tool
- Easy MySQL Setup

## Setup

```
$ git clone https://github.com/miguelpeixe/docker-sphereserver.git
$ cd docker-sphereserver
$ cp env.example .env
```

- Edit .env with your settings.
- Place mul files at the `mul/` directory _(required)_ and `scripts/` _(optional)_ at your env configured `CONFIG` directory:

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

If `.config/scripts/` directory is empty, [default scripts](https://github.com/Sphereserver/Scripts) will be used.

Data files will be placed at `.data/` directory by default:

```
.data/
  accounts/
  logs/
  save/
```

**Changes in both `.config/` and `.data/` will be applied to the server.**

### Custom sphere.ini

Optionally, you can also provide `sphere.ini` and `sphereCrypt.ini` at the `CONFIG` directory. If not provided, env generated files will be used.

Beware that some `sphere.ini` values are required for this setup to work, the following are:

```
MulFiles=mul/
ScpFiles=scripts/
WorldSave=/data/save/
AcctFiles=/data/accounts/
Log=/data/logs/
```

If you are running locally, `REST_API_PUBLIC_IP` can be set to `0`. Remotely it must be set to `1` because of docker network.

## Running

Use docker-compose to run your server:

```
$ docker-compose up
```

Keep server running by adding `-d` (detached) option:

```
$ docker-compose up -d
```

The compose file already applies _restart unless stopped_ policy.

### Running with dockerized MySQL

You can run with a dockerized MySQL with persistent volumes at `$DATA/mysql`:

```
$ docker-compose -f docker-compose-with-mysql.yml up -d
```

## Commands

You can send commands to your sphereserver by using `spherectl` command inside docker.

First you must identify the `sphere` container by running `docker ps`, then execute a sphere command like this:

```
$ docker exec [container-id] spherectl account add adminuser adminpassword
$ docker exec [container-id] spherectl account adminuser plevel 7
```

## Backups

You can set hourly backups by setting the `ENABLE_BACKUPS` to `1`. Backups can also be manual by running `spherebackup` inside the container:

```
$ docker exec [container-id] spherebackup
```

Manual backups can be executed even if `ENABLE_BACKUPS` is disabled.

Compressed backup files will be located at `backups/` inside the `DATA` directory. From there you can setup your own cleanup or remote storage setup. **These backups are NOT automatically deleted and can consume a lot of storage from time**.
