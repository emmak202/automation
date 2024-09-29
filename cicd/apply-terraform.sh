#!/bin/bash

set -eu

ls
cd 
 
terraform init

terraform plan

terraform apply -auto-approve