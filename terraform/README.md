## Provisioning an AWS EC2 Instance using "Terraform"
Create terraform directory and add the following 3 files;
```sh
├── root  
│   └── terraform  
│       ├── ec2.tf  
│       ├── providers.tf  
│       ├── variables.tf  
```

`ec2.tf` contains the below resource blocks;  

1. Create a VPC as "tf-vpc" with CIDR range 10.0.0.0/16
2. Create a subnet as "subnet-tf" for the VPC 
3. Craete a internet gateway as "tf-gw" and attach it to the vpc 
4. Craete a route table as "route-table-tf" and attach it to the vpc
5. Associate the subnet with route table
6. Create a security group as "tf-sg" to allow SSH 
7. Create EC2 instance 
8. Create and attach the Elastic IP to the EC2 Instance 

`providers.tf` contains the provider details (AWS in this case)

`variables.tf` contains the variables (values can be passed at execution time)




