# ansible-wordpress
Using ansible to deploy wordpress with monitoring

- Require ansible to be installed on the current machine. 
- By default, use public key for ssh login to remote host. Please put the key in the top folder and name it as pub.pem
- If using password to login:
    - Need to install sshpass
    - Rename "Makefile-Using pass" to Makefile
    - Edit inventory file, delete "ansible_ssh_private_key_file=pub.pem"
 - Edit inventory file with hostname or IP of your servers
    
#### Init remote host - install python (neccessary for ansible deployment) if needed
```
  make init
```

#### Test remote host connection

```
  make connect
```

#### Deploy wordpress,mysql,ez server monitor and graphite to remote host

```
  make deploy
```


- To use graphite dashboard, you need to initilize wordpress first. Then go to Plugins and activate StatsD WordPress Client.
This plugin collect metrics from Wordpress, report to StatsD and eventually sent to Graphite. 
- For simple host metrics as: CPU, RAM, DISK usage and Apache + mySQL services up/down, I use ez server monitor. Access the dashboard at http://server_ip/esm

================================================================

## EXPLAIN ON THE PLAYBOOK 

- There are 4 roles in the playbook

```
  db          //to install mysql database in mysql server
  wordpress   //to install wordpress (apache, php, wp) in web server. Access via http://server_ip
  esm         //to install dz server monitor v2.5 in web server. Access via http://server_ip/esm
  graphite    //to install graphite/statsd plugin for wp running as docker container in webserver. 
              //Access dashboard: http://13.229.84.27:8080/dashboard#Sample_DashBoard
```

- The db name, user, password are defined in group_vars/all. Feel free to change according to your needs. (It won't break     the code) 
- I use wordpress latest version with php7 and apache2 installed on webserver.
- graphite/grafana running on Docker Container in the WebServer. You can reach each of services at:
```
graphite: http://server_ip:8080
grafana: http://server_ip:3000

grafana can import data from graphite using endpoint hostname "graphite"
```

