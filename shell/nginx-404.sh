#!/bin/bash
sed -i '/^http {/a client_header_buffer_size 1k;\nlarge_client_header_buffers 5 5k;' /usr/local/nginx/conf/nginx.conf
