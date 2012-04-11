#!/bin/bash
	cat news.html \
		| sed '/<script type="text\/javascript"/,/<\/script>/d'  \
    | grep -o "<p>.*</p>" news.html \
    | sed 's/<[^>]*>//g' 

