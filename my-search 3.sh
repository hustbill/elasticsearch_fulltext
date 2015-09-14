echo;
curl -X POST http://localhost:9200/test/person/_mapping -d '{
"person" : {
        "properties" : {
            "my_attachment" : { "type" : "attachment" }
        }
    }
}'


curl "http://localhost:9200/test_attachments/_search?pretty=true" -d '{
   "query": {
		  "match": {
		       "_all": "Data model"
     	}
    }
}'

Pivot

curl "http://localhost:9200/test_attachments/_search?pretty=true" -d '{
  "query": {
     "match": {
       "_all": "john"
     }
   }
}'



{
   "query": {
     "match": {
       "_all": "test"
     }
   }
}







curl -X POST http://localhost:9200/test_attachments -d '{

curl -X POST http://localhost:9200/test/person -d '{
  "mappings" : {
    "document" : {
      "properties" : {
        "my_attachment" : {
          "type" : "attachment"
        }
      }
    }
  }
}'



echo;
echo '>>> Index the document'
curl -i -X PUT http://localhost:9200/test_attachments/document/1 -d "{
  \"_name\"    : \"test.doc\",
  \"content\"  : \"$(openssl base64 -in test.doc)\"
}"



echo;
echo '>>> Index the document'
curl -i -X PUT http://localhost:9200/test/person/1 -d "{
 "my_attachment" : {
        "_content_type" : "application/pdf",
        "_name" : "splunk.pdf",
        "_language" : "en",
        "_content" : "... base64 encoded attachment ..."
    }
}"

