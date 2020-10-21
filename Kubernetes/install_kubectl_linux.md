To install **kubectl** on Linux, follow the instruction below:

****

**Download the latest stable kubectl binary, make it executable and move it to the PATH:**
**\$ curl -LO "https://storage.googleapis.com/kubernetes-release/release/\$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl && sudo mv kubectl /usr/local/bin/**

Where **[https://storage.googleapis.com/kubernetes-release/release/stable.txt](https://storage.googleapis.com/kubernetes-release/release/stable.txt)** aims to display the latest Kubernetes stable release version.

**NOTE:** To download and setup a specific version of **kubectl** (such as v1.19.1), issue the following command:

**\$ curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.1/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/**

****

**A typical helpful post-installation configuration is to enable [shell autocompletion](echo%20'source%20<(kubectl%20completion%20bash)'%20>>~/.bashrc) for kubectl. It can be achieved by running the following four commands: **

**\$ sudo apt install -y ****bash-completion**

**\$ source /usr/share/****bash-completion****/****bash-completion******

**\$ ****source \<(kubectl completion bash)**

**\$ ****echo 'source \<(kubectl completion bash)' \>\>\~/.bashrc**
