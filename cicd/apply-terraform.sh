#!/bin/bash

set -eu

cd ..
 
terraform init

terraform plan

terraform apply -auto-approve