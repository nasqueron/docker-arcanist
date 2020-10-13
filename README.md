Arcanist as a Docker container
==============================

We provide a `nasqueron/arcanist` image to run **Arcanist** as a Docker container.

Our goal is to be able to use `arc` when we tweak a Docker image on a Docker engine server, where PHP isn't installed. To have an Arcanist image allows us not to install PHP everywhere.

Installation
------------

You only have to pull our image, then invoke a shell or Arc directly:

```
docker pull nasqueron/arcanist

docker run -it --rm nasqueron/arcanist bash
docker run -it --rm nasqueron/arcanist arc anoid
```

Configuration and workspace volumes
-----------------------------------

We provide two volumes, one to store the configuration (.arcrc, .gitconfig), one to store the repository you want to work with.

You probably want to pass the current directory as workspace directory. Use `pwd` (Docker won' t like `.`, and the Docker client could be on another machine than the server by the way).

To store the configuration, create a `~/.arc` folder with:

 - `~/.arc/arcrc`: a copy of your .arcrc file
 - `~/.arc/gitconfig` : a copy of your .gitconfig file

I want an arc command
---------------------

It could be convenient to create a wrapper script in `/usr/local/bin/arc` to be able to directly write `arc diff`:

```
cat > /usr/local/bin/arc
#!/bin/sh

if [ "$1" = "shell" ]; then
        shift
        COMMAND=bash
else
        mkdir -p ~/.arc
        COMMAND=arc
fi

docker run -it --rm -v ~/.arc:/opt/config -v `pwd`:/opt/workspace nasqueron/arcanist $COMMAND $*
```

You can now use `arc shell` to get an interactive shell with your local directory content sent to the container, and `arc <whatever>` in other cases.

> **Note:**

> If you use `arc call-conduit` you can't use -it, as you need to pass stdin to the command.

I want a comprehensive arc command
-----------------------------------

We provide in `contrib/` folder a choice amongst two wrappers to offer
a more comprehensive `arc` command:

- `contrib/arc` is the recommended choice: if launched as root,
  it will use the image as is, but if launched as an user, it will bootstrap
  by building once a `nasqueron/arcanist:<your uid>-<your gid>` small image
  to be able to run the container as any arbitrary unprivileged user

- `contrib/arc-runs-as-root` is the legacy version if you prefer to skip
  the build mechanism and run your container as privileged user

The need for a specific image for user is mainly if you want to use ssh,
as the OpenSSH client requires the running user to exist, and so requires
a little more than just add `--user $UID` to the docker run command.

The `contrib/arc` offers also a `arc update` command to pull the latest
nasqueron/arcanist image and rebuild the user image if needed.

Both wrappers solve the conduit issue by redirecting the output to logging,
exiting the container when done, waiting a little time then reading the log.

They've been battle-tested and used happily to maintain Git repositories
for some dozens of Docker images and tools used on a PaaS built on Docker.
