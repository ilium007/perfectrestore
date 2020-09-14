#
# perfectrestore.rsc
# Version: 0.1.1
# Author: Jonathan Cutrer
# License: MIT
# Project: https://github.com/joncutrer/perfectrestore
#
 
{
 
:local targetfile "flash/backup.rsc"   
 
# Wait for interfaces to initialize
:delay 15s
 
# Setup temporary logging to disk
/system logging action add disk-file-count=1 disk-file-name=flash/perfectrestore.log disk-lines-per-file=4096 name=perfectrestore target=disk
/system logging add action=perfectrestore topics=system,info
/system logging add action=perfectrestore topics=script,info
/system logging add action=perfectrestore topics=warning
/system logging add action=perfectrestore topics=error
/system logging add action=perfectrestore topics=critical
/system logging add action=perfectrestore topics=debug
 
# Import the rsc file
:log info "BEGIN IMPORT file=$targetfile"
import $targetfile
:log info "END IMPORT file=$targetfile"
 
# Post import delay
:delay 10s
 
# Teardown temporary logging to disk
/system logging remove [/system logging find where action=perfectrestore]
/system logging action remove [/system logging action find where name=perfectrestore] 
 
}
