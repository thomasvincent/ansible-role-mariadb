#!/usr/bin/env python

class FilterModule(object):
    """Custom filters for MariaDB role"""

    def filters(self):
        return {
            'calculate_buffer_pool_size': self.calculate_buffer_pool_size,
            'normalize_mysql_privileges': self.normalize_mysql_privileges
        }

    def calculate_buffer_pool_size(self, total_memory_mb, percentage=0.5, min_size_mb=128, max_size_mb=None):
        """Calculate optimal InnoDB buffer pool size based on system memory"""
        calculated = int(total_memory_mb * percentage)
        
        if min_size_mb and calculated < min_size_mb:
            calculated = min_size_mb
            
        if max_size_mb and calculated > max_size_mb:
            calculated = max_size_mb
            
        return f"{calculated}M"

    def normalize_mysql_privileges(self, privileges):
        """Normalize MySQL privilege strings to consistent format"""
        if isinstance(privileges, str):
            return privileges
            
        if isinstance(privileges, list):
            return ','.join(privileges)
            
        return '*.*:USAGE'
