# justdoit
Simple parallel-ssh wrapper. Contains 3 tools: exec.sh, play.sh and patch.sh. By default read ssh_confg and settings from current directory and stores known_hosts same.

## exec.sh
Simply executes command on server(s).

Usage:

    exec.sh "command" <server1 server2 ...|hostsfile>

## play.sh
Executes provided script on server(s).

Usage:

    play.sh <script> <server1 server2 ...|hostsfile>

## patch.sh
Copy and apply patch on server(s). Patch must contain absolute paths.

Usage:

    patch <patch> <server1 server2 ...|hostsfile>
## settings
Hosts file contains list of hosts described in ssh_config. For example:

ssh_config:

    UserKnownHostsFile known_hosts
    StrictHostKeyChecking no
    ConnectTimeout 5
    
    host frontend-1
        hostname 10.1.1.100
        user root
        identityfile /cryptovault/private-web.rsa
    host backend-1
        hostname 10.1.1.101
        user root
        identityfile /cryptovault/private-web.rsa
    host db-1
        hostname 10.1.1.102
        user root
        identityfile /cryptovault/private-web.rsa
    # other hosts in same subnet
    host 10.1.1.*
        user root
        identityfile /cryptovault/private-web.rsa
    
    host router
        hostname 192.168.88.1
        user admin
        identityfile /cryptovault/private-hardware.rsa
    host switch
        hostname 192.168.88.254
        user admin
        identityfile /cryptovault/private-hardware.rsa
    host hypervisor
        hostname 192.168.88.100
        user root
        identityfile /cryptovault/private-hardware.rsa

File web.list:

    frontend-1
    backend-1
    db-1
    
File network-hardware.list

    router
    switch
