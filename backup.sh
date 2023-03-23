#!/bin/bash

ls /backups/connected
if [ $? -gt 0 ] ; then
  google-drive-ocamlfuse /backups
fi

screen -S server -X stuff 'psudo tellraw @a "§9[Linux] Cloud Backup starting"\r'
screen -S server -X stuff 'save-all\r'
sleep 5
cd /servers/minecraftserver/

#world
tar cvzf "/backups/world.tar.gz" "/servers/minecraftserver/world/"
#nether
tar cvzf "/backups/world_nether.tar.gz" "/servers/minecraftserver/world_nether/"
#end
tar cvzf "/backups/world_nether_end.tar.gz" "/servers/minecraftserver/world_the_end/"

if [ $success -eq $num ] ; then
	screen -S server -X stuff 'psudo tellraw @a "§9[Linux] Cloud Backup completed"\r'
else
	failed=$(($num-$success))
	screen -S server -X stuff 'psudo tellraw @a "§9[Linux] Cloud Backup failed."\r'
fi