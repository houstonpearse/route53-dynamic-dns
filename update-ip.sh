DOMAIN_NAME=example.com
HOSTED_ZONE_ID=hostedzoneid
TTL=60
AWS_PROFILE=route53-dynamic-dns

ROUTE_53_IP=$(aws route53 list-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --query "ResourceRecordSets[?Type == 'A'].ResourceRecords[0].Value" --output text --profile "$AWS_PROFILE")
echo "IP address on route53 is $ROUTE_53_IP"

IP_ADDRESS=$(curl -s ipinfo.io/ip)
echo "IP address is $IP_ADDRESS"

if [ "$ROUTE_53_IP" = "$IP_ADDRESS" ]; then
    echo "IP is up to date"
    exit 1
fi

PAYLOAD=$(sed "s/\$ip_address/$IP_ADDRESS/" payload.json | sed "s/\$domain_name/$DOMAIN_NAME/" | sed "s/\$ttl/$TTL/")
echo "Ip is out of date. sending payload:"
echo "$PAYLOAD"
RESPONSE=$(aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch "$PAYLOAD" --profile "$AWS_PROFILE")
echo "response:"
echo "$RESPONSE"
