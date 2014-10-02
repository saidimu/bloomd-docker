#
# bloomd Dockerfile
#
# https://github.com/saidimu/bloomd-docker
#

# Pull base image.
FROM dockerfile/ubuntu

# Install bloomd.
ADD bloomd.conf /data/
RUN \
  mkdir -p /tmp/bloomd && \
  wget https://github.com/armon/bloomd/archive/v0.7.4.tar.gz -O - | tar -xvz --strip=1 -C /tmp/bloomd && \
  apt-get update && \
  apt-get -y install scons && \
  cd /tmp/bloomd && \
  scons && \
  mv /tmp/bloomd/bloomd /usr/local/bin/ && \
  rm -rf /tmp/bloomd

# Define mountable data folder
VOLUME /data

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/usr/local/bin/bloomd", "-f", "/data/bloomd.conf"]

# Expose ports.
EXPOSE 8673
