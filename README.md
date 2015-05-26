tmate-docker
============

## Usage

Tmate.io docker server

Run it as a priviledged image or even better add some this capabilitites:

* `SETUID`
* `SYS_ADMIN`
* `SYS_CHROOT`
* `SETGID`

If you want to build it:
```
docker build -t tmate-docker .
```

If you want to use it, and you built it:
```
sudo docker run --cap-add SETUID --cap-add SYS_ADMIN --cap-add SYS_CHROOT --cap-add SETGID -p 2222 -t tmate-docker
```

Or, if you just want to use it (without downloading and building it online) just do:
```
sudo docker run --cap-add SETUID --cap-add SYS_ADMIN --cap-add SYS_CHROOT --cap-add SETGID --privileged -p 2222 -t simonswine/tmate-docker
```

To know which port was tmate binded, run:
```
docker ps # this will show you the container id
docker port <container id> 2222
```

By default tmate-docker will bind inside the container on port 2222. This means that the ssh command that tmate will give you will include that port.
Sometimes you want to run on a different port. To do that you need to set the ```PORT``` environment variable, this will be the one that tmate will bind to inside the container.

In a similar manner, the advertised hostname to connect to can be
changed with the ```HOST``` environment variable. By default, the docker
container name is used.

For example:
```
docker run --cap-add SETUID --cap-add SYS_ADMIN --cap-add SYS_CHROOT --cap-add SETGID -e HOST=example.com -e PORT=443 -p 443:443 -t simonswine/tmate-docker
```

## Thanks

Thanks to nviennto for the tmate software (https://github.com/nviennot/tmate-slave) and to nicopace, whose original Dockerfiles I used.

