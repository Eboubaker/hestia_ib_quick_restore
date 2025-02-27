FROM ubuntu:22.04


# Install dependencies
RUN apt-get update && apt-get install -y restic wget && \
    wget https://downloads.rclone.org/v1.69.1/rclone-v1.69.1-linux-amd64.deb && \ 
    apt-get install -y ./rclone-v1.69.1-linux-amd64.deb

RUN restic self-update && rclone selfupdate

RUN mkdir -p /root/.config/rclone

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
COPY rclone.conf /root/.config/rclone/rclone.conf
COPY restic.conf /restic.conf

RUN chmod +x /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]