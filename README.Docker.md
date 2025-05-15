# Docker Support for MariaDB Ansible Role

This Ansible role includes Docker configuration for development and testing purposes. The Docker setup allows you to quickly test the MariaDB installation without needing to provision a full virtual machine.

## Quick Start

### Prerequisites

- Docker
- Docker Compose

### Starting the Containers

```bash
# Start MariaDB and phpMyAdmin containers
docker-compose up -d
```

### Accessing MariaDB

```bash
# Connect to the MariaDB server
docker-compose exec mariadb mysql -u root -proot

# Run a query
docker-compose exec mariadb mysql -u root -proot -e "SHOW DATABASES;"
```

### Accessing phpMyAdmin

Open http://localhost:8080 in your browser and log in with:

- Server: mariadb
- Username: root
- Password: root (or the value of MARIADB_ROOT_PASSWORD in your environment)

## Configuration

### Environment Variables

You can customize the Docker container by setting environment variables:

```bash
# Set environment variables
export MARIADB_ROOT_PASSWORD=secure_password
export MARIADB_DATABASE=custom_db
export MARIADB_USER=app_user
export MARIADB_PASSWORD=app_password

# Start with custom configuration
docker-compose up -d
```

Alternatively, create a `.env` file with the variables:

```
MARIADB_ROOT_PASSWORD=secure_password
MARIADB_DATABASE=custom_db
MARIADB_USER=app_user
MARIADB_PASSWORD=app_password
```

### Custom Configuration

To use a custom MariaDB configuration:

1. Create a configuration file in the `config/` directory:

```bash
mkdir -p config
cp templates/server.cnf.j2 config/custom.cnf
```

2. Edit `config/custom.cnf` with your desired settings
3. Restart the containers:

```bash
docker-compose down
docker-compose up -d
```

## Testing

### Manual Testing

```bash
# Test connection
docker-compose exec mariadb mysqladmin -u root -proot ping

# Test creating a database
docker-compose exec mariadb mysql -u root -proot -e "CREATE DATABASE test_db;"

# Test creating a user
docker-compose exec mariadb mysql -u root -proot -e "CREATE USER 'test_user'@'%' IDENTIFIED BY 'password';"
docker-compose exec mariadb mysql -u root -proot -e "GRANT ALL PRIVILEGES ON test_db.* TO 'test_user'@'%';"
```

### Automated Testing

The Makefile includes a Docker testing target:

```bash
# Run Docker tests
make test-docker
```

This will:
1. Build the Docker image
2. Start the containers
3. Run a test query
4. Tear down the containers

## Development Workflow

Use this Docker setup for efficient development:

1. Make changes to your Ansible role
2. Rebuild and test with Docker:

```bash
docker-compose down
docker build -t mariadb-ansible-test .
docker-compose up -d
```

3. Verify your changes:

```bash
docker-compose exec mariadb mysql -u root -proot -e "SHOW VARIABLES LIKE '%version%';"
```

## Container Structure

- `/var/lib/mysql`: Database data (persisted through a Docker volume)
- `/etc/mysql/mariadb.conf.d/99-custom.cnf`: Custom configuration
- Port 3306: Exposed for MariaDB connections

## Troubleshooting

### Container Won't Start

Check the logs:

```bash
docker-compose logs mariadb
```

### Connection Issues

Verify network settings:

```bash
docker network ls
docker network inspect ansible-role-mariadb_backend
```

### Data Persistence

To completely reset data:

```bash
docker-compose down -v  # Removes volumes
docker-compose up -d    # Fresh start
```