-- MariaDB Security Settings
-- Managed by Ansible

-- These commands are equivalent to mysql_secure_installation

-- Remove anonymous users
DELETE FROM mysql.user WHERE User='';

-- Disallow remote root login
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Remove test database
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

-- Reload privileges
FLUSH PRIVILEGES;
