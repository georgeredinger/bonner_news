#!/bin/bash
curl -s  http://www.bonnercountydailybee.com/site/news_of_record/  | grep -o "/site/news_of_record/article.*.html" | sort -u | sed "s/^/http:\/\/www.bonnercountydailybee.com\//" \
| while read url; do
   curl -s "$url"
done
	
