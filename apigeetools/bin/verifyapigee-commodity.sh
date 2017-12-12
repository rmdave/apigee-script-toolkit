#!/bin/bash
# set -xv
apigee_routers="noardapiap08 noardapiap09 noardapiap10 noardapiap11 noardapiap12 rdxl1cn01 rdxl1cn02 rdxl1cn03 rdxl1cn04 rdxl1cn05 rdxl1cn06 rdxl1cn07 rdxl1cn08 noanjapiap08 noanjapiap09 noanjapiap10 noanjapiap11 noanjapiap12 njxl1cn01 njxl1cn02 njxl1cn03 njxl1cn04 njxl1cn05 njxl1cn06 njxl1cn07 njxl1cn08"

router=noardapiap08
DEBUG=true

client_id="cd63dcd8bbf77d41eb486e0eca7958d4"
client_secret="d2c65b7c11f915bbab58ef781be7b2bb"
curlout="-o /dev/null"
if [ "$DEBUG" = "true" ]; then
        curlout=""
fi

# for router in $apigee_routers; do
echo $router
        response=`curl -s -H "X-Nintendo-Region: 1" -H "X-Nintendo-Platform-ID: 1" -H "X-Nintendo-Device-ID: ga100pabz22o" -H "X-Nintendo-Client-Secret: $client_secret" -H "X-Nintendo-Serial-Number: GA100pabz22o" -H "X-Nintendo-Country: US" -H "Content-Type: application/xml" -H "X-Nintendo-Device-Cert: mockcert" -H "Accept-Language: en" -H "X-Nintendo-System-Version: FFFF" -H "X-Nintendo-Client-ID: $client_id" -H "X-Nintendo-Device-Type: 1" -k -w "%{http_code} %{TIME_TOTAL}" -H "X-Skip-Cache-Lookup:true" -H "Host: account.nintendo.net" "http://$router.noa.nintendo.com:9090/api/content/agreements/NINTENDO-NETWORK-EULA/US/@latest" $curlout --max-time 10`
        httpcode=`echo $response | /usr/bin/cut -d' ' -f1`
        if [ "$httpcode" = "200" ]; then
                httpcode="OK"
        else
                httpcode="ERROR"
        fi
        time=`echo $response | /usr/bin/cut -d' ' -f2`
        printf "   Get EULA: %s (%.3fs)\n" $httpcode $time
        response=`curl -s -H "X-Nintendo-FPD-Version: 0000" -H "Accept-Language: en" -H "X-Nintendo-Device-Type: 2" -H "X-Nintendo-Serial-Number: FW100529623" -H "X-Nintendo-Unique-ID: 00000" -H "X-Nintendo-Country: US" -H "X-Nintendo-Client-Secret: $client_secret" -H "X-Nintendo-Region: 1" -H "X-Nintendo-Client-ID: $client_id"  -H "X-Nintendo-Application-Version: 0000" -H "X-Nintendo-Platform-ID: 1" -H "X-Nintendo-System-Version: FFFF" -H "X-Nintendo-Environment: T1" -H "X-Nintendo-Device-ID: 1141865486" -H "X-Nintendo-Device-Cert: hoge"  -d 'password=password12&grant_type=password&user_id=prodtest1' -H "X-Skip-Cache-Lookup:true" -H "Host: account.nintendo.net" -X POST "http://$router.noa.nintendo.com:9090/api/oauth20/access_token/generate" -H "X-Skip-Cache-Lookup:true" -w "%{http_code} %{TIME_TOTAL}" $curlout --max-time 10`
        httpcode=`echo $response | /usr/bin/cut -d' ' -f1`
        if [ "$httpcode" = "200" ]; then
                httpcode="OK"
        else
                httpcode="ERROR"
        fi
        time=`echo $response | /usr/bin/cut -d' ' -f2`
        printf "   Generate Access Token: %s (%.3fs)\n" $httpcode $time
        response=`curl -s -H "X-Nintendo-FPD-Version: 0000" -H "Accept-Language: en" -H "X-Nintendo-Device-Type: 2" -H "X-Nintendo-Serial-Number: 1" -H "X-Nintendo-Unique-ID: 00000" -H "X-Nintendo-Country: US" -H "X-Nintendo-Client-Secret: $client_secret" -H "X-Nintendo-Region: 1" -H "X-Nintendo-Client-ID: $client_id"  -H "X-Nintendo-Application-Version: 0000" -H "X-Nintendo-Platform-ID: 1" -H "X-Nintendo-System-Version: FFFF" -H "X-Nintendo-Environment: T1" -H "X-Nintendo-Device-ID: 2234567891" -H "X-Nintendo-Device-Cert: hoge"  -H "Host: account.nintendo.net" -X GET "http://$router.noa.nintendo.com:9090/api/content/time_zones/US/en" -H "X-Skip-Cache-Lookup:true" -w "%{http_code} %{TIME_TOTAL}" $curlout --max-time 10`
        httpcode=`echo $response | /usr/bin/cut -d' ' -f1`
        if [ "$httpcode" = "200" ]; then
                httpcode="OK"
        else
                httpcode="ERROR"
        fi
        time=`echo $response | /usr/bin/cut -d' ' -f2`
        printf "   Get Timezone: %s (%.3fs)\n" $httpcode $time
# done