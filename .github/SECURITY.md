# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |

## Reporting a Vulnerability

The maintainers of this Ansible role take security issues seriously. We appreciate your efforts to disclose your findings responsibly and will make every effort to acknowledge your contributions.

To report a security vulnerability, please follow these steps:

1. **Do not report security vulnerabilities through public GitHub issues.**
2. Email the maintainer at [security@example.com](mailto:security@example.com) with a detailed description of the issue.
3. Include steps to reproduce the vulnerability, if possible.
4. Include details about the potential impact of the vulnerability.

You will receive a response acknowledging receipt of your vulnerability report. We will work with you to understand and validate the issue.

After the initial reply to your report, the security team will keep you informed about the progress towards a fix and full announcement, and may ask for additional information or guidance.

## Security Update Process

1. Security issues will be addressed as a top priority.
2. A fix will be developed and tested.
3. A new version will be released containing the fix.
4. An advisory will be published to alert users to the vulnerability.

## Security Best Practices for Using This Role

1. **Always use secure passwords**: For MariaDB root, replication users, and application users.
2. **Restrict network access**: Limit access to the database server by configuring the `mariadb_bind_address` and `mariadb_allowed_hosts` variables.
3. **TLS encryption**: Enable TLS encryption for production environments by setting `mariadb_tls_enabled: true` and providing appropriate certificates.
4. **Regular backups**: Enable automated backups with `mariadb_backup_enabled: true` and test recovery regularly.
5. **Principle of least privilege**: Configure database users with only the permissions they need.
6. **Keep updated**: Ensure you're using the latest version of this role and MariaDB to benefit from security fixes.

## Security Features in This Role

This role includes several security features by default:

- Secure installation removing test databases and anonymous users (`mariadb_secure_installation: true`)
- Disallowing remote root login (`mariadb_disallow_root_login_remotely: true`)
- Support for TLS encryption
- Automated backup capabilities with encryption
- Proper file permissions for configuration files
- Support for audit logging