#!/bin/bash

region=$1
tagname=$2
tagvalue=$3

instancelist=`aws ec2 describe-instances --region $region  --output text \
--filters "Name=instance-state-name,Values=running" \
"Name=tag-key,Values=$tagname" "Name=tag-value,Values=$tagvalue" \
--query Reservations[*].Instances[*].InstanceId | tr -s '\t' '\n'`

for iid in `echo $instancelist`; do
  echo "setting ec2 tag maxcpu for $iid"
  aws ec2 create-tags --region $region --resources $iid --tags Key=maxcpu,Value=0
done
