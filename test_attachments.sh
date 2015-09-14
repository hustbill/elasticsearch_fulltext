curl -X DELETE http://localhost:9200/test_attachments
 
echo;
curl -X POST http://localhost:9200/test_attachments -d '{
  "mappings" : {
    "document" : {
      "properties" : {
        "content" : {
          "type" : "attachment",
          "fields" : {
            "content"  : { "store" : "yes" },
            "author"   : { "store" : "yes" },
            "title"    : { "store" : "yes", "analyzer" : "english"},
            "date"     : { "store" : "yes" },
            "keywords" : { "store" : "yes", "analyzer" : "keyword" },
            "_name"    : { "store" : "yes" },
            "_content_type" : { "store" : "yes" }
          }
        }
      }
    }
  }
}'
 
echo;
echo '>>> Index the document'
curl -i -X PUT http://localhost:9200/test_attachments/document/1 -d "{
  \"_name\"    : \"test.txt\",
  \"content\"  : \"$(openssl base64 -in test.txt)\"
}"
 
echo;
curl -X POST http://localhost:9200/test_attachments/_refresh
 
echo; echo ">>> Search for  AfterFunc"
curl "http://localhost:9200/test_attachments/_search?pretty=true&q=content.context:AfterFunc"
