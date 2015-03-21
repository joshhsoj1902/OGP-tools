#!/bin/bash

SESSION_NAME=openttd$(date +%m%d%Y_%H%M%S)
PARAMS=""

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -g)
	echo $2
	if [ ! -f $2 ]; then
    		echo "File not found!"
	else
		PARAMS="$PARAMS $key $2"
	fi
    #EXTENSION="$2"
    shift
    ;;
    *)
	PARAMS="$PARAMS $key"
	echo $key
            # unknown option
    ;;
esac
shift
done

echo $PARAMS

screen -A -m -d -S $SESSION_NAME ./openttd $PARAMS 

trap bashtrap EXIT
bashtrap()
{
        echo "shutdown"
        screen -S $SESSION_NAME -X stuff 'save save/openttd'`echo -ne '\015'`
        screen -S $SESSION_NAME -X stuff 'exit'`echo -ne '\015'`
}

while :                
do
        sleep 60
done

exit 0

