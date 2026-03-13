#!/bin/bash

REGION="east-us-2"

INSTANCE_IDS=$(aws ec2 describe-instances \
  --region "$REGION" \
  --filters "Name=tag:autoschedule,Values=true" "Name=instance-state-name,Values=stopped\\" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text)

if [ -z "$INSTANCE_IDS" ]; then
  echo "No running instances found with autoschedule=true"
else
  echo "Starting instances: $INSTANCE_IDS"
  aws ec2 stop-instances --region "$REGION" --instance-ids $INSTANCE_IDS
fi