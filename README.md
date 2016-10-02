Elasticsearch
=============

## Required
- Elasticsearch 2.4.0
- Logstash 2.4.0
- Kibana 4.5.1

## Install & Setup

```bash
$ ./bin/setup.sh

$ ./bin/init_configure.sh

$ vi conf/logstash/twitter.conf
# Edit configure for twitter and Elasticsearch
```

- Key and Secret for twitter app -> [Twitter Apps](https://apps.twitter.com/)

## Start Elasticsearch & Kibana in Foreground

```bash
$ elasticsearch
```

```bash
$ kibana
```

To stop elasticsearch or kibana, push ```Ctl+C```.

## Start Logstash

```bash
# Test configure
$ logstash -f conf/logstash/twitter.conf --configtest
Configuration OK

# Run
$ logstash -f conf/logstash/twitter.conf
Settings: Default pipeline workers: 4
Pipeline main started
```

To stop logstash, push ```Ctl+C``` twice.

## [Search](https://www.elastic.co/guide/en/elasticsearch/reference/2.4/search.html)

### Simple Search

- Reference
  - [URI Search](https://www.elastic.co/guide/en/elasticsearch/reference/2.4/search-uri-request.html)
  - [Request Body Search](https://www.elastic.co/guide/en/elasticsearch/reference/2.4/search-request-body.html)

- Search tweet by user. 

```bash
# URI Search (all type in index)
$ curl -XGET 'http://localhost:9200/twitter/_search?q=user:betahikaru&pretty=true'

# URI Search (specify type in index)
$ curl -XGET 'http://localhost:9200/twitter/type1/_search?q=user:betahikaru&pretty=true'

# Request Body Search (all type in index)
$ curl -XGET 'http://localhost:9200/twitter/_search?pretty=true' -d '{
  "query" : {
    "term" : { "user" : "betahikaru" }
  }
}'
```

- Search 'foo' keyword whole tweet.

```bash
$ curl -XGET 'http://localhost:9200/twitter/_search?pretty=true' -d '{
  "query" : {
    "simple_query_string" : {
      "query": "foo",
      "fields": ["_all"],
      "default_operator": "and"
    }
  }
}'
```

### Count

- Reference
  - [Count API](https://www.elastic.co/guide/en/elasticsearch/reference/2.4/search-count.html)

```bash
$ curl -XGET 'http://localhost:9200/twitter/_count?q=user:betahikaru&pretty=true'

$ curl -XGET 'http://localhost:9200/twitter/_count?pretty=true' -d '
{
    "query" : {
        "term" : { "user" : "betahikaru" }
    }
}'
```

## [Mapping](https://www.elastic.co/guide/en/elasticsearch/reference/2.4/mapping.html)

- [Get Mapping](https://www.elastic.co/guide/en/elasticsearch/reference/2.4/indices-get-mapping.html)

```bash
$ curl -XGET 'http://localhost:9200/twitter/_mapping/type1?pretty=true'
{
  "twitter" : {
    "mappings" : {
      "type1" : {
        "properties" : {
          "@timestamp" : {
            "type" : "date",
            "format" : "strict_date_optional_time||epoch_millis"
          },
          "@version" : {
            "type" : "string"
          },
          "client" : {
            "type" : "string"
          },
          ...
        }
      }
    }
  }
}
```

## [cat APIs](https://www.elastic.co/guide/en/elasticsearch/reference/2.4/cat.html)

- Reference
  - [count](https://www.elastic.co/guide/en/elasticsearch/reference/2.4/cat-count.html)

```bash
$ curl -XGET 'http://localhost:9200/_cat/indices'
yellow open ldgourmet 5 1 101 0 339.5kb 339.5kb
yellow open twitter   5 1 649 0 958.9kb 958.9kb
yellow open books     5 1   3 0    10kb    10kb
yellow open .kibana   1 1   4 0  19.7kb  19.7kb
```

## Delete index

```bash
$ curl -XDELETE 'http://localhost:9200/twitter'
```
