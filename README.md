[![Docker Build Status](https://img.shields.io/docker/build/oznu/cloudflare-ddns.svg?label=x64%20build&style=for-the-badge)](https://hub.docker.com/r/oznu/cloudflare-ddns/) [![Travis](https://img.shields.io/travis/oznu/docker-cloudflare-ddns.svg?label=arm%20build&style=for-the-badge)](https://travis-ci.org/oznu/docker-cloudflare-ddns)

# Docker CloudFlare DDNS

This small Alpine Linux based Docker image will allow you to use the free [CloudFlare DNS Service](https://www.cloudflare.com/dns/) as a Dynamic DNS Provider ([DDNS](https://en.wikipedia.org/wiki/Dynamic_DNS)).

## Usage

Quick Setup:

```shell
docker run \
  -e EMAIL=hello@example.com \
  -e API_KEY=xxxxxxx \
  -e ZONE=example.com \
  -e SUBDOMAIN=subdomain \
  oznu/cloudflare-ddns
```

This image will also run on a Raspberry Pi or any other ARM based boards that support Docker:

```shell
docker run \
  -e EMAIL=hello@example.com \
  -e API_KEY=xxxxxxx \
  -e ZONE=example.com \
  -e SUBDOMAIN=subdomain \
  oznu/cloudflare-ddns:armhf
```

## Parameters

* `--restart=always` - ensure the container restarts automatically after host reboot.
* `-e EMAIL` - Your CloudFlare email address. **Required**
* `-e API_KEY` - Your CloudFlare API Key. Get it here: https://www.cloudflare.com/a/profile. **Required**
* `-e ZONE` - The DNS zone that DDNS updates should be applied to. **Required**
* `-e SUBDOMAIN` - A subdomain of the `ZONE` to write DNS changes to. If this is not supplied the root zone will be used.
* `-e PROXIED` - Set to `true` to make traffic go through the CloudFlare CDN. Defaults to `false`.

## Multiple Domains

If you need multiple records pointing to your public IP address you can create CNAME records in CloudFlare.

## Docker Compose

If you prefer to use [Docker Compose](https://docs.docker.com/compose/):

```yml
version: '2'
services:
  cloudflare-ddns:
    image: oznu/cloudflare-ddns
    restart: always
    environment:
      - EMAIL=hello@example.com
      - API_KEY=xxxxxxx
      - ZONE=example.com
      - SUBDOMAIN=subdomain
```
