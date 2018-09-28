#!/bin/bash

#This is where the variable is set, and can be changed.
IP='127.0.0.1' 

#This redirects any output to a garvage file instead of the screen.
ping -c5 $IP > /dev/null

#This if statement outputs a message to the screen based on ping results.
if [ "$?" = 0 ]
then
  echo "Host reachable"
else
  echo "Host not reachable"
fi  
