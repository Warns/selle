# To break tf blob storage lease when terraform plan/apply gets stuck
az storage blob lease break -b terraform.tfstate -c tstate --account-name tstateidentity15466 --account-key 3eJ1HRfV/D7TavxKmhcxwvap4ZvEBOhz+NpWmJUoWIQsV/7jvVRO5UZuA==
