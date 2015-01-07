#!/bin/bash

INSTANCE=$1

rm current_output_log.txt
ln -s instances/$INSTANCE/logs/current_output_log.txt current_output_log.txt 

sudo 7dtd.sh start $INSTANCE

trap bashtrap EXIT

bashtrap()
{
        sudo 7dtd.sh kill $INSTANCE
	rm current_output_log.txt
}

while :                
do
        sleep 60
done

exit 0

