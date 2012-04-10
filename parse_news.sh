#!/bin/bash
grep -o "<p>.*</p>" news.html | sed 's/<[^>]*>//g'
