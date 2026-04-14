# 42Inception

> A Docker-based infrastructure project — running a full web stack inside a virtual machine.

`Inception` is a 42 Common Core system administration project. The goal is to set up a small but complete infrastructure using **Docker Compose**, where each service runs in its own dedicated container. The project is deployed inside a Virtual Machine and is built entirely from custom Dockerfiles — no pre-built images from Docker Hub are allowed (except for base OS images).

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Services](#services)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Directory Structure](#directory-structure)
- [Configuration](#configuration)

---

## Overview

The project provisions a production-like multi-container environment entirely through Docker. All containers are built from scratch using either Alpine Linux or Debian as the base image. A `Makefile` is provided to automate the build and deployment process. Persistent data is stored in Docker volumes.

---

## Architecture

```
┌─────────────────────────────────────────────────┐
│                   Virtual Machine                │
│                                                 │
│  ┌────────────┐    ┌────────────┐               │
│  │   NGINX    │───▶│ WordPress  │               │
│  │ (TLS only) │    │  + PHP-FPM │               │
│  └────────────┘    └─────┬──────┘               │
│                          │                      │
│                    ┌─────▼──────┐               │
│                    │  MariaDB   │               │
│                    └────────────┘               │
│                                                 │
│  Volumes: wordpress_data, mariadb_data          │
│  Network: inception_network (docker bridge)     │
└─────────────────────────────────────────────────┘
```

---

## Services

| Service | Description |
|---|---|
| **NGINX** | Reverse proxy and TLS termination — exposes port 443 only (HTTPS via TLSv1.2/1.3) |
| **WordPress** | CMS running with PHP-FPM, connected to MariaDB |
| **MariaDB** | MySQL-compatible relational database for WordPress data |

---

## Requirements

- Docker Engine
- Docker Compose (v2+)
- GNU Make
- A running Virtual Machine (or Linux host)
- `openssl` (for TLS certificate generation)

---

## Installation

Clone the repository inside your Virtual Machine:

```bash
git clone https://github.com/NicoloRomito/42Inception.git
cd 42Inception
```

Create a `.env` file in the `srcs/` directory with the required variables (see [Configuration](#configuration)).

Build and launch all services:

```bash
make
```

---

## Usage

**Start all containers:**

```bash
make up
# or:
docker compose -f srcs/docker-compose.yml up -d --build
```

**Stop all containers:**

```bash
make down
```

**View logs:**

```bash
docker compose -f srcs/docker-compose.yml logs -f
```

**Rebuild a specific service:**

```bash
docker compose -f srcs/docker-compose.yml up -d --build nginx
```

**Full teardown (stops containers, removes volumes and images):**

```bash
make fclean
```

Once running, access WordPress at: `https://login.42.fr` (replace `login` with your 42 intra username).

---

## Directory Structure

```
42Inception/
├── Makefile
└── srcs/
    ├── docker-compose.yml
    ├── .env                        # Environment variables (not committed)
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/               # nginx.conf / default.conf
        ├── wordpress/
        │   ├── Dockerfile
        │   └── conf/               # www.conf (PHP-FPM pool config)
        └── mariadb/
            ├── Dockerfile
            └── conf/               # my.cnf or init scripts
```

---

## Configuration

Create `srcs/.env` with the following variables:

```env
# Domain
DOMAIN_NAME=login.42.fr

# MariaDB
DB_NAME=wordpress
DB_USER=wp_user
DB_PASSWORD=your_db_password
DB_ROOT_PASSWORD=your_root_password

# WordPress
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=your_wp_admin_password
WP_ADMIN_EMAIL=admin@example.com
WP_USER=editor
WP_USER_PASSWORD=your_wp_user_password
WP_USER_EMAIL=editor@example.com
```

> **Never commit the `.env` file.** It is included in `.gitignore`.

---

*Project developed at 42 Firenze as part of the Common Core curriculum.*
