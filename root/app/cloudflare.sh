#!/usr/bin/with-contenv sh

cloudflare() {
  curl -sSL \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -H "X-Auth-Email: $EMAIL" \
    -H "X-Auth-Key: $API_KEY" \
    "$@"
}

getPublicIpAddress() {
  dig +short @resolver1.opendns.com myip.opendns.com A
}

getDnsRecordName() {
  if [ ! -z "$SUBDOMAIN" ]; then
    echo $SUBDOMAIN.$ZONE
  else
    echo $ZONE
  fi
}

verifyToken() {
  cloudflare -o /dev/null -w "%{http_code}" "$CF_API"/user
}

getZoneId() {
  cloudflare "$CF_API/zones?name=$ZONE" | jq -r '.result[0].id'
}

getDnsRecordId() {
  cloudflare "$CF_API/zones/$1/dns_records?type=A&name=$2" | jq -r '.result[0].id'
}

createDnsRecord() {
  if [[ "$PROXIED" != "true" && "$PROXIED" != "false" ]]; then
    PROXIED="false"
  fi

  cloudflare -X POST -d "{\"type\": \"A\",\"name\":\"$2\",\"content\":\"$3\",\"proxied\":$PROXIED}" "$CF_API/zones/$1/dns_records" | jq -r '.result.id'
}

updateDnsRecord() {
  if [[ "$PROXIED" != "true" && "$PROXIED" != "false" ]]; then
    PROXIED="false"
  fi

  cloudflare -X PUT -d "{\"type\": \"A\",\"name\":\"$3\",\"content\":\"$4\",\"proxied\":$PROXIED}" "$CF_API/zones/$1/dns_records/$2" | jq -r '.result.id'
}

getDnsRecordIp() {
  cloudflare "$CF_API/zones/$1/dns_records/$2" | jq -r '.result.content'
}
