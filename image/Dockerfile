FROM node:20-bookworm as node
RUN apt-get update && \
    apt-get install -y python3 && \
    apt-get install -y python3-pip && \
    apt-get install -y nginx

COPY image/requirements.txt /breakfast/image/
RUN pip3 install --break-system-packages -r /breakfast/image/requirements.txt

RUN openssl genrsa -out /www-key.pem 2048 && \
    openssl req -new -key /www-key.pem -subj "/C=SE/O=Breakfast" -out /www-cert.csr && \
    openssl x509 -req -days 9125 -in /www-cert.csr -signkey /www-key.pem -out /www-cert.pem

COPY . /breakfast/

RUN cd /breakfast/client && npm install
RUN cd /breakfast/client && npx vite build

ARG nginx_conf
COPY $nginx_conf /etc/nginx/nginx.conf

# Create non-privileged user, but change the uid/gid of the existing user "node" first to avoid clashes
RUN groupmod -g 900 node
RUN usermod -u 900 -g 900 node
ENV USER_NAME runner
ARG host_uid=1001
ARG host_gid=1001
RUN groupadd -g $host_gid $USER_NAME
RUN useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME

WORKDIR /breakfast

CMD ["image/start.sh"]

