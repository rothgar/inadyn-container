inadyn container
---

Docker container for running [inadyn](https://github.com/troglobit/inadyn)

Compiled using debian and multi-stage build

## Build

```
docker build -t inadyn .
```

## Run with

Create a inadyn.conf file in the local directory. Use examples from the inadyn repo.

```
provider google {
    username = xxxxxxxxx
    password = xxxxxxxxx
    ssl      = true
    hostname = example.com
}
```

Then run the container with

```
docker run -d -v $PWD:/srv rothgar/inadyn:2.2 /usr/local/bin/inadyn --foreground --config=/srv/inadyn.conf
```
