#!/bin/bash
# Helper script to test MariaDB connection

# Set defaults
HOST=${1:-localhost}
PORT=${2:-3306}
USER=${3:-root}
PASSWORD=${4:-molecule_test_password}
DATABASE=${5:-mysql}

# Functions
function log_info() {
  echo "[INFO] $1"
}

function log_error() {
  echo "[ERROR] $1" >&2
}

function test_connection() {
  log_info "Testing connection to MariaDB at $HOST:$PORT..."
  mysql -h "$HOST" -P "$PORT" -u "$USER" -p"$PASSWORD" -e "SELECT 1;" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    log_info "✅ Connection successful!"
    return 0
  else
    log_error "❌ Connection failed!"
    return 1
  fi
}

function test_database_exists() {
  if [ -z "$DATABASE" ] || [ "$DATABASE" = "mysql" ]; then
    return 0
  fi
  
  log_info "Checking if database '$DATABASE' exists..."
  DB_EXISTS=$(mysql -h "$HOST" -P "$PORT" -u "$USER" -p"$PASSWORD" -e "SHOW DATABASES LIKE '$DATABASE';" | grep -c "$DATABASE")
  if [ "$DB_EXISTS" -gt 0 ]; then
    log_info "✅ Database '$DATABASE' exists!"
    return 0
  else
    log_error "❌ Database '$DATABASE' does not exist!"
    return 1
  fi
}

function test_server_status() {
  log_info "Checking server status..."
  RESULT=$(mysql -h "$HOST" -P "$PORT" -u "$USER" -p"$PASSWORD" -e "SHOW STATUS;" 2>/dev/null)
  if [ $? -eq 0 ]; then
    VERSION=$(mysql -h "$HOST" -P "$PORT" -u "$USER" -p"$PASSWORD" -e "SELECT VERSION();" 2>/dev/null | grep -v "VERSION()")
    UPTIME=$(mysql -h "$HOST" -P "$PORT" -u "$USER" -p"$PASSWORD" -e "SHOW STATUS LIKE 'Uptime';" 2>/dev/null | awk 'NR==2 {print $2}')
    THREADS=$(mysql -h "$HOST" -P "$PORT" -u "$USER" -p"$PASSWORD" -e "SHOW STATUS LIKE 'Threads_connected';" 2>/dev/null | awk 'NR==2 {print $2}')
    
    log_info "✅ Server status: OK"
    log_info "   Version: $VERSION"
    log_info "   Uptime: $UPTIME seconds"
    log_info "   Connected threads: $THREADS"
    return 0
  else
    log_error "❌ Could not get server status!"
    return 1
  fi
}

# Main execution
log_info "MariaDB Connection Test"
log_info "======================="
log_info "Host: $HOST"
log_info "Port: $PORT"
log_info "User: $USER"
log_info "Database: $DATABASE"
log_info "======================="

# Run tests
test_connection
CONNECTION_RESULT=$?

if [ $CONNECTION_RESULT -eq 0 ]; then
  test_database_exists
  DB_RESULT=$?
  
  test_server_status
  STATUS_RESULT=$?
  
  # Final result
  if [ $DB_RESULT -eq 0 ] && [ $STATUS_RESULT -eq 0 ]; then
    log_info "✅ All tests passed!"
    exit 0
  else
    log_error "❌ Some tests failed!"
    exit 1
  fi
else
  log_error "❌ Connection test failed. Aborting further tests."
  exit 1
fi