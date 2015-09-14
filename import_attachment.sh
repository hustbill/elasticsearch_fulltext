 #!/bin/sh

coded=`cat go.pdf | perl -MMIME::Base64 -ne 'print encode_base64($_)'`
json="{\"file\":\"${coded}\"}"
echo "$json" > json.file
curl -X POST "localhost:9200/test_attachments/document/1" -d @json.file
