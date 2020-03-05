#  Jenkins Docker Integration

```sh 
# 1. Install Publish Over SSH plugin on Jenkins
# 2. Create a user on docker to use it's credentials on Jenkins
useradd dockeradmin
passwd dockeradmin

## Add dockeradmin user to docker group
cat /etc/group
usermod -aG docker dockeradmin

## View whehther dockeradmin added to this group or not
id dockeradmin
```
