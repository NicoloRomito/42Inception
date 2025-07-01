#!/bin/bash

print_info() {
    echo -e "\e[34m[INFO]\e[0m $1"
}

print_success() {
    echo -e "\e[32m[SUCCESS]\e[0m $1"
}

print_error() {
    echo -e "\e[31m[ERROR]\e[0m $1"
}

CERT_PATH="/etc/ssl/certs/nginx-selfsigned.crt"
KEY_PATH="/etc/ssl/private/nginx-selfsigned.key"

if [[ -z "$DOMAIN_NAME" ]]; then
    print_error "Error: DOMAIN_NAME is not set"
else
    print_info "DOMAIN_NAME is set to $DOMAIN_NAME"
fi

if [[ -z "$KEY_PATH" ]]; then
    print_error "Error: KEY_PATH (Private key path) is not set"
else
    print_info "Private key path is set to $KEY_PATH"
fi

if [[ -z "$CERT_PATH" ]]; then
    print_error "Error: CERT_PATH (Certificate path) is not set"
else
    print_info "Certificate path is set to $CERT_PATH"
fi

if [ ! -f "$CERT_PATH" ] || [ ! -f "$KEY_PATH" ]; then
  echo "Generating self-signed certificate..."
  mkdir -p /etc/ssl/certs /etc/ssl/private
  openssl req -nodes -new -x509 \
      -keyout "$KEY_PATH" \
      -out "$CERT_PATH" \
      -subj "/C=IT/ST=Italy/L=Florence/O=Ecole42/OU=Luiss/CN=nromito.42.fr"

  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to generate self-signed certificate!"
  else
      echo "Self-signed certificate generated successfully."
  fi
else
  echo "Certificate already exists, skipping generation."
fi

if [[ -f /etc/nginx/nginx.conf ]]; then
    print_info "Nginx configuration file exists at /etc/nginx/nginx.conf"
else
    print_error "Error: Nginx configuration file not found!"
fi

print_info "Starting Nginx..."
nginx -g 'daemon off;'

if [[ $? -ne 0 ]]; then
    print_error "Error: Nginx failed to start! exited with code $?"
    exit 1
else
    print_success "Nginx started successfully."
fi
