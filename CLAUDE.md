# CLAUDE.md

Ansible role for enterprise MariaDB/MySQL deployment and management.

## Stack
- Ansible 9.0.0+
- Python 3.10+
- Molecule for testing
- Dependencies: community.mysql collection

## Lint & Test
```bash
ansible-lint
yamllint .
molecule test
make test-docker
```

## Notes
- High availability: primary-replica replication with automated failover
- Automated backups with retention policies and encryption
- Dynamic performance tuning based on server capacity
- Multi-instance support on single host
- Docker support via docker-compose.yml for dev/test
