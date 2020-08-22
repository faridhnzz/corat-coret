* Remove Package Docker
```
apt remove docker-ce* --purge -y
apt remove --auto-remove docker -y
apt remove docker* --purge -y
apt autoremove --purge -y
rm -rf /var/lib/docker
```

* Remove Network Docker
```
ip link delete docker0
```
