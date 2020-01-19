FROM nginx:1.17.5

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Install 3rd Party cache purge module https://github.com/nginx-modules/ngx_cache_purge
# Adds ability to purge content proxy cache with the "proxy_cache_purge" directive
# Needs testing - not sure this works correctly
COPY install_cache_purge.sh ./
RUN ./install_cache_purge.sh

# Configure Nginx and apply fix for very long server names
RUN sed -i 's/worker_processes  1/worker_processes  auto/' /etc/nginx/nginx.conf

# Copy in config
COPY vhost.extra/* /etc/nginx/vhost.extra/
COPY vhost.d/* /etc/nginx/vhost.d/
COPY conf.d/* /etc/nginx/conf.d/
COPY network_internal.conf /etc/nginx/

# Persist certs, cache and dhparam
VOLUME ["/etc/nginx/certs", "/etc/nginx/dhparam", "/var/cache/nginx"]
