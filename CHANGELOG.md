# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- GitHub Actions CI/CD workflows
  - Comprehensive testing across all Molecule scenarios
  - Ansible version matrix testing (2.14, 2.15, 2.16, devel)
  - Automated releases with changelog generation
  - Ansible Galaxy publishing
- ansible-lint configuration with production profile
- yamllint strict configuration
- SECURITY.md with comprehensive security guidelines
- CHANGELOG.md for version tracking
- Example playbooks directory with common scenarios

### Enhanced
- CI/CD automation with job summaries
- Documentation with security best practices
- Test coverage reporting

## [1.0.0] - 2025-01-24

### Added
- Initial enterprise-grade MariaDB role
- Multi-instance support
- Primary-replica replication
- Automated backup with encryption
- Performance optimization
- Comprehensive monitoring with Prometheus
- Database and user provisioning
- Version management and controlled upgrades
- Audit logging
- Docker support for development

### Features
- Secure by default configuration
- High availability support
- Automated failover
- Health checks and alerting
- Compliance with security standards

### Testing
- Molecule testing with multiple scenarios:
  - Default installation
  - Backup functionality
  - Monitoring capabilities
  - Multi-instance deployment
  - Version matrix across MariaDB versions
- Docker-based testing
- Support for Ubuntu, Debian, Rocky Linux

### Documentation
- Comprehensive README
- Docker setup guide
- Roadmap document
- Contributing guidelines
- API documentation in defaults/main.yml

[Unreleased]: https://github.com/thomasvincent/ansible-role-mariadb/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/thomasvincent/ansible-role-mariadb/releases/tag/v1.0.0
