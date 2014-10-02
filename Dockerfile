#
# bloomd Dockerfile
#
# https://github.com/saidimu/bloomd-docker
#

# Pull base image.
FROM dockerfile/ubuntu

# Install bloomd.
RUN \
  mkdir -p /tmp/bloomd && \
  wget https://github.com/armon/bloomd/archive/v0.7.4.tar.gz -O - | tar -xvz --strip=1 -C /tmp/bloomd && \
  apt-get update && \
  apt-get -y install scons && \
  rm -rf /var/lib/apt/lists/* && \
  cd /tmp/bloomd && \
  scons && \
  mv /tmp/bloomd/bloomd /usr/local/bin/ && \
  rm -rf /tmp/bloomd

# Define mountable data folder
VOLUME /data

# Define working directory.
WORKDIR /data

# Copy default conf file to mountable folder
ADD bloomd.conf /data/

# Define default command.
CMD ["/usr/local/bin/bloomd", "-f", "/data/bloomd.conf"]

# Expose ports.
EXPOSE 8673
