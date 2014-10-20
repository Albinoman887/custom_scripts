#!/bin/bash
#! --------------------------------------------------------------------------
#! XBMC Library Auto-Update Commander v3.0
#! --------------------------------------------------------------------------
#! Info: Replacement for watzens's old .vbs script
#! based on wget for use in Linux :)
#! 
#! Switched my fileserver to Linux so i needed a new (old)
#! way of sending the update library command along with
#! the source path, and i came up with this. Now with an
#! added option of parsing source path and update msg
#! from command line. 
#!
#! Significance of this is that you can now dynamicly set 
#! the source path. if the porgram you use to launch this 
#! supports wildcards for source path (SCRU, uTorrent) 
#! you can have the calling app parse the filepath of the 
#! media in question to the script. mimimizing errors and 
#! making it much easier to use with multiple source paths.
#!
#! Usage: Pretty similar to the old script minus the Queued
#! torrent functions. Simply fill out at least one client and
#! your path to the source. if you want it to parse from 
#! command line no need to change from default. 
#! SOURCE is the first arg ($1) and MSG is the 2nd arg ($2)
#!
#! Example: ./update-xbmc.sh "/Media/Movies/DVDRips/" "New DVDRips"
#! or:            ./update-xbmc.sh /Media/TVs/Weeds Weeds
#!
#! Albinoman887
#!

#! Runtime Options. Set Clients and path below
#! ==================================================
#!
#! Set your clients.

CLIENT1="http://192.168.1.40:8080"
CLIENT2="http://laptop-htpc:8080"
CLIENT3="http://192.168.1.139:8080"

#! Set static Source Path (or $! to call from command line)

SOURCE="$1"

#! Set a message to display to the user (or $2 to call from command line)

MSG="$2"

#! ===================================================
#! ---------------DO NOT EDIT BELOW THIS LINE---------

#! Set Variables
UPDATESTRING="/jsonrpc?request=%7B%20%22jsonrpc%22%3A%20%222.0%22%2C%20%22method%22%3A%20%22VideoLibrary.Scan%22%2C%20%22params%22%3A%20%7B%20%22directory%22%3A%20%22$SOURCE%22%20%7D%20%7D"
NOTIFYSTRING="/jsonrpc?request=%7B%20%22jsonrpc%22%3A%20%222.0%22%2C%20%22method%22%3A%20%22GUI.ShowNotification%22%2C%20%22params%22%3A%20%7B%20%22title%22%3A%20%22Auto%20Library%20Updater%22%2C%20%22message%22%3A%20%22New%20$MSG%20Being%20Added%22%20%7D%2C%20%22id%22%3A%201%20%7D%0A"


#! Begin Script
echo ----------------------------------------------------------------------------
echo      XBMC Library Update Commander Invoked....
echo ----------------------------------------------------------------------------
sleep 5

#! Client 1
echo ----------------------------------------------------------------------------
echo     Sending NotifyString $MSG to $CLIENT1
echo ----------------------------------------------------------------------------
wget -O - "$CLIENT1$NOTIFYSTRING"
echo ----------------------------------------------------------------------------
echo                  Sleep 10 secs...
echo ----------------------------------------------------------------------------
sleep 10
echo ----------------------------------------------------------------------------
echo     Sending UpdateString $SOURCE to $CLIENT1
echo ----------------------------------------------------------------------------
wget -O - "$CLIENT1$UPDATESTRING"
echo ----------------------------------------------------------------------------
echo                 Sleep 10 secs...
echo ----------------------------------------------------------------------------
sleep 10
echo ----------------------------------------------------------------------------
echo                    Done
echo ----------------------------------------------------------------------------

#! Client 2
echo ----------------------------------------------------------------------------
echo     Sending NotifyString $MSG to $CLIENT2
echo ----------------------------------------------------------------------------
wget -O - "$CLIENT2$NOTIFYSTRING"
#echo ----------------------------------------------------------------------------
#echo                  Sleep 3 secs...
#echo ----------------------------------------------------------------------------
#sleep 3
#echo ----------------------------------------------------------------------------
#echo     Sending UpdateString $SOURCE to $CLIENT2
#echo ----------------------------------------------------------------------------
#wget -O - "$CLIENT2$UPDATESTRING"
echo ----------------------------------------------------------------------------
echo                 Sleep 10 secs...
echo ----------------------------------------------------------------------------
sleep 10
echo ----------------------------------------------------------------------------
echo                   Complete.
echo ----------------------------------------------------------------------------
