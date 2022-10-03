#!/bin/bash

region=$1
tagname=$2
tagvalue=$3

#linux date
#onehourago=`date -u +%FT%TZ -d "1 hour ago"`
#now=`date -u +%FT%TZ`

#macos date
onehourago=`date -v -1H -u +%FT%TZ`
now=`date -u +%FT%TZ`

instancelist=`aws ec2 describe-instances --region $region  --output text \
--filters "Name=instance-state-name,Values=running" \
"Name=tag-key,Values=$tagname" "Name=tag-value,Values=$tagvalue" \
--query Reservations[*].Instances[*].InstanceId | tr -s '\t' '\n'`

for iid in `echo $instancelist`; do
echo "checking metrics for $iid"

#query cloudwatch for the avg cpu value in the past hour
current_cpu=`aws cloudwatch --region $region get-metric-statistics \
--namespace AWS/EC2 --metric-name CPUUtilization \
--start-time $onehourago --end-time $now \
--period 3600 --statistics Average --dimensions Name=InstanceId,Value=$iid \
--query Datapoints[].Average --output text`

#query the tag value for the instance
tag_value=`aws ec2 --region $region describe-tags \
--filter "Name=resource-id,Values=$iid" "Name=key,Values=maxcpu" \
--query Tags[*].Value --output text`

#if the queried value from cloudwatch is higher than the tag value, update the tag
if [[ $current_cpu > $tag_value ]]; then
  echo "$current_cpu will be set as tag value"
  aws ec2 create-tags --region $region --resources $iid --tags Key=maxcpu,Value=$current_cpu
fi

#if the current and tagged values are both less than 30, echo a message that the instance is a candidate for downsizing
if [[ $current_cpu < 30 && $tag_value < 30 ]]; then
  echo "Instance ID $iid is a candidate for downsizing"
fi


done
