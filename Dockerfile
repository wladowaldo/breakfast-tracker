FROM node:latest
RUN apt-get update && \
    apt-get install -y python3 && \
    apt-get install -y python3-pip && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 install --break-system-packages flask-restx restx-monkey Werkzeug flask-cors

# Create non-privileged user, but change the uid/gid of the existing user "node" first to avoid clashes
RUN groupmod -g 900 node
RUN usermod -u 900 -g 900 node
ENV USER_NAME runner
ARG host_uid=1001
ARG host_gid=1001
RUN groupadd -g $host_gid $USER_NAME
RUN useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME
USER $USER_NAME

WORKDIR /breakfast

CMD ["gui/start_gui_components.sh"]

