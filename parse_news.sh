#!/bin/bash
	cat news.txt \
	  | awk -f <(cat - <<- 'EOD'
	      BEGIN { FS=":" }
        /Date:/ {print "--------------"; printf "Date:%s\n", $2 }
				/^12-[0-9]* / {
				  code=match($0,/([1-2][2-9]-.*)/);
					desc=match($0,/[1-2][2-9]-(.*)/);
					printf("code: %s\n",substr($0,code,9));
					printf("desc: %s\n",substr($0,desc+10),10)
				}			

	      /Incident Address/ {print "--------------"; printf "Address:%s\n", $2}			
	      /Responding Officers/ { printf "Officers:%s\n", $2}			
				/Disposition/ { printf "Disposition:%s\n",$2}
				/Unit/ { 
				         unit=match($0,/Unit: (.*) /);
								 if(unit){
								   printf("Unit: %s\n",substr($0,unit+5,5));
								 }
                time_reported=match($0,/Time Reported.*([0-9][0-9]\:[0-9][0-9])/);
								 if(time_reported){
								   printf("time_reported: %s\n",substr($0,time_reported+15,5));
								 }

				         time_dispatched=match($0,/Time Dispatched.*([0-9][0-9]\:[0-9][0-9])/);
								 if(time_dispatched) {
								   printf("time_dispatched: %s\n",substr($0,time_dispatched+17,5));
								 }
								 
				       }
        /Time Arrived : [0-9][0-9]:[0-9][0-9]/ {
          time_arrived=match($0,/Time Arrived.*([0-9][0-9]\:[0-9][0-9])/);
          if(time_arrived) {
      	    printf("time_arrived: %s\n",substr($0,time_arrived+15,5));
          }
        }
        /Time Completed : [0-9][0-9]:[0-9][0-9]/ {
    	 	  time_completed=match($0,/Time Completed.*([0-9][0-9]\:[0-9][0-9])/);
    		  if(time_completed) {
    			  printf("time_completed: %s\n",substr($0,time_completed+17,5));
    		  }
        }
    
		
				/Dispatch Summary Statement/ { printf "Summary:%s\n",$2}

EOD
) 


