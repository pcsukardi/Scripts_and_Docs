#!/bin/bash
IP='45.79.158.194'
ping $IP 2>/dev/null 1>/dev/null &

if [ "$?" = 0 ]
then
  echo "Host found"
else
  echo "Host not found"
fi  
