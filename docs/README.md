# MariaDB Role Documentation

## Basic Usage

```yaml
- hosts: database_servers
  roles:
    - role: thomasvincent.mariadb
      vars:
        mariadb_root_password: "securepassword"
        mariadb_databases:
          - name: appdb
            encoding: utf8mb4
            collation: utf8mb4_unicode_ci
        mariadb_users:
          - name: appuser
            password: "userpassword"
            priv: "appdb.*:ALL"
```

## Advanced Configurations

### High Availability Master-Slave Setup

```yaml
# Master server configuration
- hosts: db_master
  roles:
    - role: thomasvincent.mariadb
      vars:
        mariadb_replication_enabled: true
        mariadb_replication_role: master
        mariadb_server_id: 1
        mariadb_replication_user: replicator
        mariadb_replication_password: "replpass"
        mariadb_bind_address: "0.0.0.0"

# Slave server configuration
- hosts: db_slaves
  roles:
    - role: thomasvincent.mariadb
      vars:
        mariadb_replication_enabled: true
        mariadb_replication_role: slave
        mariadb_server_id: "{{ ansible_default_ipv4.address | regex_replace('\\.', '') }}"
        mariadb_replication_user: replicator
        mariadb_replication_password: "replpass"
        mariadb_replication_master_host: "{{ hostvars[groups['db_master'][0]].ansible_host }}"
```

### Performance Tuning for Different Workloads

#### OLTP Configuration (High Transaction Load)
```yaml
mariadb_performance_tuning_enabled: true
mariadb_innodb_buffer_pool_size: "{{ (ansible_memtotal_mb * 0.7) | int }}M"
mariadb_innodb_log_file_size: "512M"
mariadb_innodb_flush_log_at_trx_commit: 1
mariadb_max_connections: 1000
mariadb_tmp_table_size: "128M"
```

#### OLAP Configuration (Analytics Workload)
```yaml
mariadb_performance_tuning_enabled: true
mariadb_innodb_buffer_pool_size: "{{ (ansible_memtotal_mb * 0.8) | int }}M"
mariadb_innodb_log_file_size: "1G"
mariadb_innodb_flush_log_at_trx_commit: 0
mariadb_join_buffer_size: "8M"
mariadb_sort_buffer_size: "8M"
mariadb_tmp_table_size: "256M"
```

## Architecture

This role follows domain-driven design principles to organize functionality into:

- **Installation Domain**: Package management, repository configuration
- **Configuration Domain**: Server setup, performance tuning
- **Security Domain**: Access controls, encryption, hardening
- **Data Management Domain**: Database and user provisioning
- **High Availability Domain**: Replication, clustering
- **Operational Domain**: Backups, monitoring, maintenance

Each domain is implemented with SOLID principles and idempotent operations.
