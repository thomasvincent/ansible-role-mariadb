# Docker Support for MariaDB Role

This directory contains Docker configurations to help with development and testing of the MariaDB Ansible role.

## Quick Start

### Using Docker Compose

The easiest way to get started is with Docker Compose:

```bash
# Start the containers
docker-compose up -d

# Check the status
docker-compose ps

# Access the MariaDB shell
docker-compose exec mariadb mariadb -uroot -p

# Stop the containers
docker-compose down
```

### Environment Variables

Configure the deployment by setting these environment variables:

```bash
export MARIADB_ROOT_PASSWORD=your_secure_password
export MARIADB_DATABASE=your_database
export MARIADB_USER=your_user
export MARIADB_PASSWORD=your_password

docker-compose up -d
```

### Accessing phpMyAdmin

The phpMyAdmin interface is available at http://localhost:8080 with the following credentials:
- Server: mariadb
- Username: root
- Password: The value of MARIADB_ROOT_PASSWORD

## Building the Docker Image

If you want to build and use the Docker image directly:

```bash
# Build the image
docker build -t local/mariadb:10.6 .

# Run a container
docker run -d --name mariadb \
  -p 3306:3306 \
  -e MARIADB_ROOT_PASSWORD=secure_password \
  -e MARIADB_DATABASE=app_db \
  -e MARIADB_USER=app_user \
  -e MARIADB_PASSWORD=app_password \
  local/mariadb:10.6
```

## Using with Development

This Docker setup is particularly useful for:

1. Quickly testing changes to the MariaDB configuration
2. Verifying application compatibility with MariaDB
3. Developing and testing backup/restore scripts
4. Simulating replication scenarios

## Custom Configuration

Edit the `config/custom.cnf` file to adjust MariaDB settings without rebuilding the image.