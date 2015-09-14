#!/bin/sh

coded=`cat myfile.txt | perl -MMIME::Base64 -ne 'print encode_base64($_)'`
json="{\"file\":\"${coded}\"}"
echo "$json" > json.file
curl -X POST "localhost:9200/events/attachment/" -d @json.file
