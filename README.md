# VPN Pritunl Sourced from [ContainerInfra](https://gitlab.com/containerinfra/pritunl)

[![pipeline status](https://gitlab.com/containerinfra/pritunl/badges/master/pipeline.svg)](https://gitlab.com/containerinfra/pritunl/commits/master)

> Pritunl (https://pritunl.com/) VPN set-up in a Docker container.

This repository contains a basic set-up for installing Pritunl using Docker. There are various other options floating around, most which also contain a mongodb installation. The aim is to provide a minimal installation for running Pritunl.

This installation is used for hobby purposes, and may or may not be appropiate for any other production use case. Feel free to fork, modify, PR, etc.

## Table of Contents

- [Usage](#usage)
- [Automated build](#Automated build)
- [Contribute](#contribute)
- [License](#license)

## Usage

### Configuration

| Environment               | Description |
| ------------------------- | ---------------------------------------------------------------------------------------------------- |
| `PRITUNL_DEBUG`             | must be true or false - controls the debug config key. |
| `PRITUNL_BIND_ADDR`         | must be a valid IP on the host - defaults to `0.0.0.0` - controls the bind_addr config key. |
| `PRITUNL_MONGODB_URI`       | URI to mongodb instance. Required, no default value. Example: `mongodb://mongo-database:27017/pritunl`. |
| `PRITUNL_SERVER_KEY_PATH` | Private key location for the Pritunl server. Default is `/var/lib/pritunl/pritunl.key` |
| `PRITUNL_SERVER_CERT_PATH` | Certificate location for the Pritunl server. Default is `/var/lib/pritunl/pritunl.crt` |

See [Pritunl documentation](https://docs.pritunl.com/docs/configuration-5) for more information on how to configure Pritunl.

### Deployment

Example deployment using docker-compose:

```yaml
version: '2.2'

services:
  pritunl:
    image: registry.gitlab.com/containerinfra/pritunl:1.29
    ports: ['1194:1194/udp', '1194:1194/tcp', '80:80', '443:443']
    environment:
      PRITUNL_MONGODB_URI: mongodb://mongo-database:27017/pritunl
    privileged: true

  mongo-database:
    image: mongo
```

Run `docker-compose up` to start.

### Securing Pritunl

Please read the documentation about [securing pritunl](https://docs.pritunl.com/docs/securing-pritunl) when deploying into production.

> For production usage, ensure you are backing up your Mongodb instance(s) and configure TLS / authentication.
> See: https://docs.pritunl.com/docs/configuration-5#section-database-security

### Running in host mode

If you want better network performance, try running the Pritunl instance using `network_mode: 'host'`. Running in host mode will by-pass the Docker network stack, potentially increasing performance and decrease packet loss.

When doing this, remember to open the relevant ports on your local firewall.

### Available tags

| Tag | Notes |
|-----|-------|
| `latest` | Latest CI build |
| `1.29` | Pritunl v1.29 |

## Automated build

This image is build at least once a month automatically. All PR's are automatically build.

## Contribute

PRs accepted. All issues should be reported in the [Gitlab issue tracker](https://gitlab.com/avisi/centos/issues).

## License

[MIT © ContainerInfra](LICENSE)
