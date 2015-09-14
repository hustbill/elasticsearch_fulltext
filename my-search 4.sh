#!/bin/sh


curl -X DELETE "localhost:9200/go"

curl -X PUT "localhost:9200/go" -d '{
  "settings" : { "index" : { "number_of_shards" : 1, "number_of_replicas" : 0 }}
}'



curl -X PUT "localhost:9200/go/attachment/_mapping" -d '{
  "attachment" : {
    "properties" : {
      "file" : {
        "type" : "attachment",
        "fields" : {
          "title" : { "store" : "yes" },
          "file" : { "term_vector":"with_positions_offsets", "store":"yes" }
        }
      }
    }
  }
}'

#!/bin/sh

coded=`cat go.pdf | perl -MMIME::Base64 -ne 'print encode_base64($_)'`
json="{\"file\":\"${coded}\"}"
echo "$json" > json.file
curl -X POST "localhost:9200/go/attachment/" -d @json.file



curl "localhost:9200/_search?pretty=true" -d '{
  "fields" : ["file"],
  "query" : {
    "query_string" : {
      "query" : "os.O_RDWR"
    }
  },
  "highlight" : {
    "fields" : {
      "file" : {}
    }
  }
}'

curl "localhost:9200/go/_search?pretty=true" -d '{
  "fields" : ["file"],
  "query" : {
    "match_phrase" : {
      "about" : "os.O_RDWR"
    }
  }
}'

curl "localhost:9200/go/_search?q=os.O_RDWR&pretty=true"
curl "localhost:9200/_search?q=os.O_RDWR&pretty=true"


- 

curl "localhost:9200/_search?pretty=true" -d '{
  "fields" : ["title"],
  "query" : {
    "query_string" : {
      "query" : "os.Stdout.Write(line)"
    }
  },
  "highlight" : {
    "fields" : {
      "file" : {}
    }
  }
}'


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
  \"_name\"    : \"test.text\",
  \"content\"  : \"$(openssl base64 -in test.text)\"
}"
 
 
 #!/bin/sh

coded=`cat go.pdf | perl -MMIME::Base64 -ne 'print encode_base64($_)'`
json="{\"file\":\"${coded}\"}"
echo "$json" > json.file
curl -X POST "localhost:9200/test_attachments/document/1" -d @json.file

curl "http://localhost:9200/test_attachments/_search?q=os.O_RDWR"


curl "http://localhost:9200/test_attachments/_search?pretty=true&q=content.content:os.O_RDWR"