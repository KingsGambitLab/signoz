#!/bin/bash

# Mount the EBS Volume from ENV variable
CLICKHOUSE_DATA_PATH=/var/lib/docker/volumes/signoz-clickhouse
echo "Mounting EBS Volume"
VOLUME_ID=$(/opt/elasticbeanstalk/bin/get-config environment -k CLICKHOUSE_VOLUME)
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
aws ec2 attach-volume --region ap-south-1 --volume-id $VOLUME_ID --instance-id $INSTANCE_ID --device /dev/sdh
echo "EBS Volume attached. Waiting for 10 seconds before mounting."
sleep 10
mkdir -p $CLICKHOUSE_DATA_PATH
mount /dev/sdh $CLICKHOUSE_DATA_PATH
echo "EBS Volume mounted"
if find $ -maxdepth 0 -empty | read v; then mkfs -t ext4 /dev/sdh; fi
echo "EBS Volume formatted"
