Please configure SMTP in /tools/email to use mail notifications

```
:local sysname [/system identity get name];
:local Email "[YOUR EMAIL ADDRESS FOR NOTIFICATIONS HERE]";
:local PrimaryDNS "[YOUR PRIMARY DNS IP HERE]";
:local BackupDNS "[YOUR Backup DNS IP HERE]";
:local TestDomain "mikrotik.com"
:local ConfiguredDNS [/ip dns get servers];

###### when router is in its primary configuration
:if ($PrimaryDNS = $ConfiguredDNS) do={
    :do { 
        ###### test resolution
        :put [:resolve $TestDomain server $ConfiguredDNS];

        ###### generate syslog messages
        /log info "Primary DNS $PrimaryDNS healthcheck completed, no issues";
    } on-error={ 
        :put "resolver failed"; 
        ###### generate syslog messages
        /log info "name resolution using primary DNS $PrimaryDNS failed";
        /log info "temporary setting backup DNS $BackupDNS as primary";
        ###### update DNS with backup DNS
        /ip dns set servers=$BackupDNS; 

        ###### send notification email
        /tool e-mail send to="$Email" subject="$sysname script notification: Primary DNS $PrimaryDNS down" body="Primary DNS $PrimaryDNS is down.\r\nDNS configuration changed to backup DNS $BackupDNS."
        /log info "notification email to $Email sent";
    }
}

###### when router is in its backup configuration
:if ($BackupDNS = $ConfiguredDNS) do={
    :do { 
        ###### test resolution
        :put [:resolve $TestDomain server $PrimaryDNS];

        ###### generate syslog messages
        /log info "name resolution using primary DNS $PrimaryDNS working now";
        /log info "restoring original DNS configuration";

        ###### revert back DNS configuration to original
        /ip dns set servers=$PrimaryDNS;
        ###### send notification email
        /tool e-mail send to="$Email" subject="$sysname script notification: Primary DNS $PrimaryDNS up" body="Primary DNS $PrimaryDNS is up.\r\nOriginal DNS configuration restored."
        /log info "notification email to $Email sent";
        
    } on-error={ 
        :put "resolver failed";
        ###### generate syslog messages
        /log info "system is configured with backup DNS $BackupDNS";
        /log info "Primary DNS $PrimaryDNS is still down, next check in 300 seconds";
    }
}
```
