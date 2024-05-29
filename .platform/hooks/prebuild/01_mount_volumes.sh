#!/bin/bash

# Mount the EBS Volume from ENV variable
echo "Creating docker volumes"
docker volume create --name=signoz-clickhouse
docker volume create --name=signoz-query-service
CLICKHOUSE_DATA_PATH=/var/lib/docker/volumes/signoz-clickhouse
QUERY_DATA_PATH=/var/lib/docker/volumes/signoz-query-service
echo "Mounting EBS Volumes"
CLICKHOUSE_VOLUME_ID=$(/opt/elasticbeanstalk/bin/get-config environment -k CLICKHOUSE_VOLUME)
QUERY_VOLUME_ID=$(/opt/elasticbeanstalk/bin/get-config environment -k QUERY_SERVICE_VOLUME)
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
aws ec2 attach-volume --region ap-south-1 --volume-id $QUERY_VOLUME_ID --instance-id $INSTANCE_ID --device /dev/sdi
echo "EBS Volums attached. Waiting for 10 seconds before mounting."
sleep 10
mkdir -p $CLICKHOUSE_DATA_PATH
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $CLICKHOUSE_VOLUME_ID.efs.ap-south-1.amazonaws.com:/ $CLICKHOUSE_DATA_PATH
mkdir -p $QUERY_DATA_PATH
mount /dev/sdi $QUERY_DATA_PATH
echo "EBS Volume mounted"
if find $CLICKHOUSE_DATA_PATH -maxdepth 0 -empty | read v; then mkfs -t ext4 /dev/sdh; fi
if find $QUERY_DATA_PATH -maxdepth 0 -empty | read v; then mkfs -t ext4 /dev/sdi; fi
echo "EBS Volume formatted"
