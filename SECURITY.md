# Security Policy

## Supported Versions

We support the following versions with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

### Where to Report

Send security vulnerability reports to: **thomas.vincent@gmail.com**

### What to Include

Please include as much information as possible:

1. **Description**: Clear description of the vulnerability
2. **Impact**: Potential impact and severity
3. **Steps to Reproduce**: Detailed steps to reproduce the issue
4. **Affected Versions**: Which versions are affected
5. **Proof of Concept**: If available (code, screenshots, etc.)
6. **Suggested Fix**: If you have recommendations

### Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Fix Target**: Critical issues within 30 days

## Security Best Practices

### MariaDB Security

1. **Strong Passwords**
   ```yaml
   # ALWAYS use Ansible Vault for passwords
   mariadb_root_password: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          [encrypted content]
   ```

2. **Network Security**
   ```yaml
   # Bind to specific interface
   mariadb_bind_address: "127.0.0.1"  # Local only
   # or
   mariadb_bind_address: "10.0.1.5"   # Private network IP
   ```

3. **User Privileges**
   ```yaml
   # Follow principle of least privilege
   mariadb_users:
     - name: app_user
       password: "{{ vault_app_password }}"
       host: "192.168.1.%"  # Specific subnet only
       priv: "app_db.*:SELECT,INSERT,UPDATE,DELETE"  # Only needed privileges
   ```

4. **SSL/TLS Configuration**
   ```yaml
   mariadb_ssl_enabled: true
   mariadb_require_ssl: true
   mariadb_ssl_ca: /path/to/ca-cert.pem
   mariadb_ssl_cert: /path/to/server-cert.pem
   mariadb_ssl_key: /path/to/server-key.pem
   ```

5. **Audit Logging**
   ```yaml
   mariadb_audit_enabled: true
   mariadb_audit_log_file: /var/log/mysql/audit.log
   ```

### Role Security

1. **Secrets Management**
   - Never commit secrets to version control
   - Always use Ansible Vault for sensitive data
   - Rotate credentials regularly

2. **File Permissions**
   - Configuration files: 0644
   - SSL keys: 0600
   - Data directory: 0750

3. **Backup Security**
   ```yaml
   mariadb_backup_encryption: true
   mariadb_backup_encryption_key: "{{ vault_backup_key }}"
   ```

4. **Monitoring**
   - Enable query logging for security audits
   - Monitor failed login attempts
   - Set up alerts for suspicious activity

## Known Security Considerations

### Default Root Password

This role enforces setting a root password during installation. Never use default or weak passwords.

### Remote Access

By default, root user is restricted to localhost. For remote access:
- Use specific IP restrictions
- Require SSL/TLS
- Use key-based authentication when possible

### Replication Security

When using replication:
```yaml
mariadb_replication_user_password: !vault |
      $ANSIBLE_VAULT;1.1;AES256
      [encrypted content]
mariadb_replication_ssl: true
```

### Backup Security

Backups may contain sensitive data:
- Encrypt backup files
- Secure backup storage location
- Restrict access to backup files
- Use secure transfer methods (SCP, SFTP)

## Compliance

This role helps implement:

- **PCI DSS**: Database security requirements
- **HIPAA**: Data protection and access controls
- **SOC 2**: Security controls and monitoring
- **GDPR**: Data encryption and access logging

## Security Testing

We perform:

- **Static Analysis**: ansible-lint with security rules
- **Dependency Scanning**: Regular dependency audits
- **Molecule Testing**: Security-focused test scenarios
- **Code Review**: All changes reviewed for security impact

## Security Checklist

Before deploying to production:

- [ ] All passwords encrypted with Ansible Vault
- [ ] SSL/TLS enabled and enforced
- [ ] Firewall rules configured
- [ ] Audit logging enabled
- [ ] Backup encryption enabled
- [ ] User privileges minimized
- [ ] Root remote access disabled
- [ ] Default test databases removed
- [ ] MariaDB version is latest stable
- [ ] Security updates applied

## Additional Resources

- [MariaDB Security Documentation](https://mariadb.com/kb/en/securing-mariadb/)
- [OWASP Database Security](https://cheatsheetseries.owasp.org/cheatsheets/Database_Security_Cheat_Sheet.html)
- [CIS MariaDB Benchmark](https://www.cisecurity.org/)

## Contact

- **Security Issues**: thomas.vincent@gmail.com
- **General Issues**: [GitHub Issues](https://github.com/thomasvincent/ansible-role-mariadb/issues)

Thank you for helping keep our role secure!
