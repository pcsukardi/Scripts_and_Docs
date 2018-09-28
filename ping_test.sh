#!/bin/bash
IP='10.10.17.1'
ping $IP 2>/dev/null 1/dev/null
if [ "$?" = 0 ]
then
  echo "Host reachable"
else
  echo "Host not reachable"
fi  
