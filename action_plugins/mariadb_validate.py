#!/usr/bin/env python

from ansible.plugins.action import ActionBase

class ActionModule(ActionBase):
    """Custom action plugin for MariaDB validation"""

    def run(self, tmp=None, task_vars=None):
        result = super(ActionModule, self).run(tmp, task_vars)
        result['changed'] = False
        result['failed'] = False
        
        # Get module args
        root_password = self._task.args.get('root_password', '')
        secure_install = self._task.args.get('secure_install', True)
        
        # Perform validation
        errors = []
        
        if secure_install and not root_password:
            errors.append("Root password must be set when secure installation is enabled")
            
        # Set validation result
        if errors:
            result['failed'] = True
            result['msg'] = '; '.join(errors)
        
        return result
