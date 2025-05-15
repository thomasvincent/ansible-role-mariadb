# Enterprise MariaDB Ansible Role

An enterprise-grade Ansible role for deploying and managing MariaDB/MySQL database servers with high availability, security, and performance optimization.

## Features

- **Secure by default**: Hardened configuration, automated secure installation, and comprehensive security controls
- **High availability**: Primary-replica replication, automated failover, and cluster configuration
- **Automated backup**: Configurable backup schedules with retention policies and encryption
- **Performance optimization**: Dynamic tuning based on server capacity and workload
- **Multi-instance support**: Deploy and manage multiple MariaDB instances on a single host
- **Comprehensive monitoring**: Prometheus integration, health checks, and alerting
- **Database initialization**: Automated database and user provisioning with proper privilege management
- **Version management**: Support for controlled upgrades and version pinning
- **Audit logging**: Detailed activity tracking for compliance and security
- **Docker support**: Includes Dockerfile and docker-compose.yml for development and testing

## Getting Started

### Installation

```bash
# From Ansible Galaxy
ansible-galaxy install thomasvincent.mariadb

# From GitHub
ansible-galaxy install git+https://github.com/thomasvincent/ansible-role-mariadb.git
```

### Basic Usage

```yaml
- hosts: database_servers
  become: true
  vars:
    mariadb_root_password: "secure_password"
    mariadb_databases:
      - name: app_db
        encoding: utf8mb4
        collation: utf8mb4_unicode_ci
    mariadb_users:
      - name: app_user
        password: user_password
        host: "192.168.0.%"
        priv: "app_db.*:ALL"
  roles:
    - thomasvincent.mariadb
```

### Docker Support

This role includes Docker configuration for development and testing:

```bash
# Start MariaDB and phpMyAdmin containers
docker-compose up -d

# Test with Docker
make test-docker

# For more details, see:
cat README.Docker.md
```

## Enterprise Design Principles

This role follows enterprise software engineering best practices:

- **Domain-Driven Design (DDD)**: Clear domain separation between installation, configuration, security, etc.
- **SOLID principles**: Each component has a single responsibility with proper abstraction
- **Idempotent operations**: Safe to run repeatedly without side effects
- **Defensive programming**: Comprehensive validation, error handling, and failure recovery
- **DRY implementation**: Modular design with minimal code duplication
- **Design patterns**: Strategy, Template Method, Factory, and Decorator patterns for flexibility

## Requirements

- Ansible 7.0.0 - 7.x (tested with 7.0.0 and 7.6.0)
- Python 3.10+ (tested with 3.10)
- Root or sudo access on target hosts

## Compatibility Matrix

### Ansible Versions

| Ansible Version | Compatible | Tested    |
|-----------------|------------|-----------|
| 7.6.x           | ✅        | ✅        |
| 7.0.x - 7.5.x   | ✅        | 7.0.0 ✅   |
| 6.x.x           | ❌        | ❌        |
| 5.x.x           | ❌        | ❌        |

### Operating Systems

| OS             | Version           | Status    | Tested   |
|----------------|-------------------|-----------|----------|
| Ubuntu         | 22.04 (Jammy)     | Supported | ✅       |
| Ubuntu         | 20.04 (Focal)     | Supported | ✅       |
| Ubuntu         | 18.04 (Bionic)    | Supported | ❌       |
| Debian         | 12 (Bookworm)     | Supported | ✅       |
| Debian         | 11 (Bullseye)     | Supported | ✅       |
| Debian         | 10 (Buster)       | Supported | ❌       |
| Rocky Linux    | 9.x               | Supported | ✅       |
| Rocky Linux    | 8.x               | Supported | ✅       |
| RHEL           | 9.x               | Supported | ❌       |
| RHEL           | 8.x               | Supported | ❌       |
| RHEL           | 7.x               | Supported | ❌       |
| CentOS/Alma    | 8.x               | Supported | ❌       |
| CentOS         | 7.x               | Supported | ❌       |

### MariaDB Versions

| MariaDB Version | Status    | Tested   |
|-----------------|-----------|----------|
| 11.x            | Supported | ✅       |
| 10.11.x         | Supported | ✅       |
| 10.8.x - 10.10.x| Supported | ✅ (10.8)|
| 10.6.x - 10.7.x | Supported | ✅ (10.6)|
| 10.5.x          | Supported | ✅       |
| < 10.5.x        | Not Tested| ❌       |

## Quality Assurance

- Comprehensive testing with Molecule (v6.0.2) across supported Ansible versions and platforms
- CI/CD pipeline integration via GitHub Actions
- Role validation and linting with ansible-lint (v6.22.1)
- Compliance with Ansible best practices

## Configuration Options

See [defaults/main.yml](defaults/main.yml) for a complete list of configuration options and their default values.

## Testing

This role uses Molecule for testing multiple scenarios:

```bash
# Install testing dependencies
pip install -r requirements.txt

# Run all tests (incl. linting)
make all

# Run specific test scenarios
make molecule-test          # Default single instance
make multi-instance-test    # Primary-replica replication
make backup-test            # Backup functionality
make monitoring-test        # Monitoring capabilities
make version-matrix-test    # Tests across MariaDB versions
```

### Testing with Docker

The role includes Docker testing capabilities:

```bash
# Test basic functionality
make docker-test

# Test replication
make docker-replication-test

# Run all Docker tests
make docker-test-all
```

### CI/CD Integration

This role uses GitHub Actions for continuous integration testing. See the `.github/workflows/ci.yml` file for configuration details.

## License

MIT

## Author

Thomas Vincent