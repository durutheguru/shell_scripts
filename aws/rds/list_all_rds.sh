#!/bin/bash


## This bash script iterates over all AWS regions by using the `aws ec2 
 ## describe-regions` command to get a list of regions and then 
 ## extracting the region names using `cut`. For each region, it lists 
 ## the RDS instances using the `aws rds describe-db-instances` command 
 ## with the specified region. The output displays the DB instance 
 ## identifiers and their respective read replica identifiers.
 ## 
 ## In summary, this script lists the RDS instances and their read 
 ## replicas for each AWS region.

for region in `aws ec2 describe-regions --output text | cut -f4` 
do
echo -e "\nListing RDS in region:'$region'..."
aws rds describe-db-instances \
	--region $region \
	--query 'DBInstances[*].[DBInstanceIdentifier,ReadReplicaDBInstanceIdentifiers]' 
done

