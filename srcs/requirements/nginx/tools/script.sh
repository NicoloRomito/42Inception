#!/bin/bash

CERT_PATH="/etc/ssl/certs/nginx-selfsigned.crt"
KEY_PATH="/etc/ssl/private/nginx-selfsigned.key"

if [ ! -f "$CERT_PATH" ] || [ ! -f "$KEY_PATH" ]; then
  echo "Generating self-signed certificate..."
  mkdir -p /etc/ssl/certs /etc/ssl/private
  openssl req -nodes -new -x509 \
      -keyout "$KEY_PATH" \
      -out "$CERT_PATH" \
      -subj "/C=IT/ST=Italy/L=Florence/O=Ecole42/OU=Luiss/CN=nromito.42.fr"

  if [[ $? -ne 0 ]]; then
    print_error "Error: Failed to generate self-signed certificate!"
  else
      print_success "Self-signed certificate generated successfully."
  fi
else
  echo "Certificate already exists, skipping generation."
fi

nginx -g "daemon off;"
