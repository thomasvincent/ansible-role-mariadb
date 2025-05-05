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

- Ansible 2.10+
- Python 3.6+
- Root or sudo access on target hosts

## Supported Platforms

- Ubuntu 18.04+, 20.04+, 22.04+
- Debian 9+, 10+, 11+, 12+
- RHEL/CentOS/Rocky Linux/AlmaLinux 7+, 8+, 9+

## Quality Assurance

- Comprehensive testing with Molecule across multiple Ansible versions
- CI/CD pipeline integration via GitHub Actions
- Role validation and linting
- Compliance with Ansible best practices

## Configuration Options

See [defaults/main.yml](defaults/main.yml) for a complete list of configuration options and their default values.

## Testing

This role uses Molecule for testing:

```bash
# Install testing dependencies
pip install molecule molecule-plugins[docker] docker pytest-testinfra

# Run default test scenario
molecule test

# Test replication with multi-instance scenario
molecule test -s multi-instance
```

## License

MIT

## Author

Thomas Vincent