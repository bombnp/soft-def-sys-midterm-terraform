# Software-Defined System Terraform Midterm Project
This repository is a midterm project for the Software-Defined System course. Upon apply, it will
1. Create a VPC with 4 subnets (nat, internal, db, web)
2. Create Internet Gateway, NAT Gateway, route tables, instances, network interfaces, etc. to connect web server and db server.
3. Create S3 bucket.

Inside the web server is a WordPress app automatically installed and configured with the db server. The media files are configured to store in the S3 bucket.

## Applying the module
1. Configure AWS credentials with an IAM user with sufficient permissions. (Feel free to fine-grain the permissions. I'm using the FullAccess policies for simplicity.)
  - AmazonEC2FullAccess
  - IAMFullAccess
  - AmazonS3FullAccess
2. Run `terraform init` to initialize the module.
3. Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in the variables of your choice.
4. Run `terraform apply` to apply the module. Enter `yes` when prompted. It should take around 5 minutes to complete the apply process. Wait for 1-2 minutes for the WordPress app to be fully installed, hen it should be up and running.
5. To destroy, run `terraform destroy`. Enter `yes` when prompted.
