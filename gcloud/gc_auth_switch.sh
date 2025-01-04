#!/bin/bash

gcloud_auth_list=$(gcloud auth list)

echo -e "$gcloud_auth_list"
read -p "Enter the account to select: " account

if [ ! -z "${account// /}" ]; then
  gcloud config set account $account
else
  echo "Account not selected"
fi
