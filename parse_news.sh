#!/bin/bash
	cat news.html \
		| sed '/<script type="text\/javascript"/,/<\/script>/d'  \
    | grep -o "<p>.*</p>" news.html \
    | sed 's/<[^>]*>//g' \
	  | awk -f <(cat - <<- 'EOD'
	      BEGIN { FS=":" }
        /Date:/ { printf "Date:%s\n", $2 }
				/^12-[0-9]* / {split($0,desc," "); printf ("Description:");for(i=2;i<=length(desc);i++) {printf "%s", desc[i];print}}			
	      /Incident Address/ { printf "Address:%s\n", $2}			
	      /Responding Officers/ { printf "Officers:%s\n", $2}			
				/Disposition/ { printf "Disposition:%s\n",$2}
				/Unit/ { printf "Unit:%s\n",$2,$3-$4 $5 $6-$7}
				/Dispatch Summary Statement/ { printf "Summary:%s\n",$2}

EOD
) \
	| less


