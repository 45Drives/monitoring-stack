# Monitoring Stack

| Service Name      	| Description                                                     	|
|-------------------	|-----------------------------------------------------------------	|
| Grafana           	| Display Statistics & Metrics from database                      	|
| Alertmanager      	| Query db of metrics and send alerts based on user defined rules 	|
| Prometheus        	| Collect and store metrics scraped from exporters in database   	|
| Node Exporter     	| Export hardware and OS metrics via http endpoint                	|
| ZnapZend Exporter 	| Export state information on zfs snapshots and replication tasks 	|

The services outlined above are deployed as containers using either podman or docker depending on Host OS.
Containers are managed via systemd services and/or cockpit-podman module

## Supported OS
* Rocky Linux 8.X
* Rocky Linux 9.X
* Ubuntu 20.04
* Ubuntu 22.04

# Installation

* Clone git repo to "/usr/share"
```sh
cd /usr/share/
git clone https://github.com/45drives/monitoring-stack.git
```
* Included inventory file "hosts" has two groups "metrics" and "exporters"
    * All hosts in the "metrics" group will have prometheus, alertmanager and grafana installed
    * All hosts in the "exporters" group will have node_exporter and znapzend_exporter installed
    * By default "metrics" and "exporters" is populated by localhost. This is sufficient for a single server deployment.
        * To add multiple servers add new hosts in the "exporters" group
        * It is possible to have the metric stack not run on the same server as the exporter services.

* Configure email send/recieve setting for alertmanager in "group_vars/metrics.yml"

* Default ports are defined in the table below, they can be changed in metrics.yml or exporters.yml

| Default Setting          	| Value 	|
|--------------------------	|-------	|
| Prometheus Port          	| 9091  	|
| Alertmanager Port        	| 9093  	|
| Grafana Port             	| 3000  	|
| Grafana Default User     	| admin 	|
| Grafana Default Password 	| admin 	|
| Node Exporter Port       	| 9100  	|
| Znapzend Port            	| 9101  	|

* Run metrics playbook
```sh
cd /usr/share/monitoring-stack
ansible-playbook -i hosts deploy-monitoring.yml
```

* To uninstall monitoring stack
```sh
ansible-playbook -i hosts purge-monitoring.yml
```

# Verification

To ensure monitoring stack is working as expected, simulate failure condition and you will recieve an email notification

* Offline a disk in your zpool
    * Set disk as "Offline" in Houston UI, "ZFS + File Sharing"
    * Or in cli: zpool offline tank 1-1
* After ~30 seconds you should see email with subject line "[FIRING:1] ZpoolDegradedState ($HOSTNAME node warning degraded $POOL_NAME)"

