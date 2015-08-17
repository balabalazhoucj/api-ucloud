#!/bin/sh
. ./base.sh

#signature string
signlist=$(echo $oldlist" PublicKey=$public_key"|sed 's/ /\n/g;s/=//g'| sort -k1 | awk -vFS='\n' -vORS='' '$1=$1')$private_key
signature=$(echo -n "$signlist" | sha1sum)
signature=${signature:0:40}

#http request string
httplist=$(echo $oldlist" PublicKey=$public_key"|sed 's/ /\n/g'| sort -k1|sed 's/^/\&/g' | awk -vFS='\n' -vORS='' '$1=$1' )"&Signature=$signature"
httpurl=$(echo $httplist | sed 's/\&//')

#echo "https://api.ucloud.cn/?$httpurl"

curl -d $httpurl https://api.ucloud.cn
