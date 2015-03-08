#!/bin/bash

SESSION_NAME=terraria$(date +%m%d%Y_%H%M%S)

screen -A -m -d -S $SESSION_NAME mono TerrariaServer.exe $@

trap bashtrap EXIT
bashtrap()
{
        echo "shutdown"
        screen -S $SESSION_NAME -X stuff 'exit'`echo -ne '\015'`
}

while :                
do
        sleep 60
done

exit 0

