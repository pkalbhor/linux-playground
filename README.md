## Linux Playground

For the purpose of learning linux.
Doing all this in Ubuntu docker container so that one does not mess up anything in the host system.

Clone the repo first. Build the `Dockerfile` to docker image with

```bash
docker build -t ubuntu-bash .
```

Once build is succussful, you can run the script to start the container.
```bash
./start_ubuntu_playground.sh
```
