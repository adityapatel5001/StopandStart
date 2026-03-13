#!/bin/bash
set -e

REGION="us-east-2"

INSTANCE_IDS=$(aws ec2 describe-instances \
  --region "$REGION" \
  --filters "Name=tag:autorestart,Values=true" "Name=instance-state-name,Values=stopped" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text)

if [ -z "$INSTANCE_IDS" ] || [ "$INSTANCE_IDS" = "None" ]; then
  echo "No stopped instances found with autorestart=true in $REGION"
else
  echo "Starting instances: $INSTANCE_IDS"
  aws ec2 start-instances --region "$REGION" --instance-ids $INSTANCE_IDS
fi