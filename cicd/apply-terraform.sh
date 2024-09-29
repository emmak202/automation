#!/bin/bash

set -eu

cd /terraform
 
terraform init

terraform plan

terraform apply -auto-approve