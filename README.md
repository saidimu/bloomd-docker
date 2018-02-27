bloomd-docker
=============

A Docker image for [Armon's bloomd](https://github.com/armon/bloomd), a C network daemon for bloom filters.

#### Getting Started

```
docker run -d -p 8673:8673 saidimu/bloomd:v0.7.4
```

bloomd is now listening on port `8673` of your localhost.

#### Getting Started with fig

If you have [fig](http://www.fig.sh/) installed, clone this repository and execute the following commands:
```
git clone git@github.com:saidimu/bloomd-docker.git
cd bloomd-docker
fig up -d
fig logs
```

bloomd is now listening on port `8673` of your localhost.

#### Attach persistent/shared directories using host-mounted volumes

  1. Create a mountable data directory `<data-dir>` on the host.

  2. Create a [bloomd config file](https://github.com/armon/bloomd#configuration-options) at `$DATA_DIR/bloomd.conf`.

```ini
# Settings for bloomd
[bloomd]
tcp_port = 8673
data_dir = /data/bloomd
log_level = INFO
flush_interval = 300
workers = 2
```

  3. Start a container by mounting the data directory on the host to /data in the container:

```bash
docker run -d -p 8673:8673 -v "$DATA_DIR":/data -v "$DATA_DIR"/bloomd.conf:/etc/bloomd/bloomd.conf saidimu/bloomd:v0.7.4
```

#### Using fig with data-only containers

`fig.yml` includes definitions for a data-only container and a volume mounts for a `custom_config` folder that holds a custom config file you can provide.

