Fix time and date issue when `apt update` fails.

```sh
sudo apt install ntpdate -y
sudo ntpdate pool.ntp.org
```
