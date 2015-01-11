#!/usr/bin/python
import MySQLdb
import getpass


#addon_name           #Readable Name for the Addon
#url                  #URL to the item to download
#path                 #Local path to put the downloaded file (Must be relitave to game root, can't start or end with /)
#addon_type           #plugin,mappack,config
#home_cfg_id          #Int id of the game server found in ogp_config_homes
#post_script          #Full bash script of the command to run after downloading
def insert_addon(addon_name,url,path,addon_type,game_key,post_script):
  p = getpass.getpass(prompt='Enter root DB password:')

  db = MySQLdb.connect(host="localhost", # your host, usually localhost
                       user="root", # your username
                       passwd=p, # your password
                       db="opengamepanel") # name of the data base

  # you must create a Cursor object. It will let
  #  you execute all the queries you need
  cur = db.cursor() 

  # Use all the SQL you like
  #cur.execute("SELECT * FROM ogp_config_homes")
  cur.execute("SELECT home_cfg_id FROM ogp_config_homes WHERE game_key=%s",game_key)

  # print all the first cell of all the rows
  for row in cur.fetchall() :
      home_cfg_id = row[0]


  cur.execute("INSERT INTO ogp_addons (name,url,path,addon_type,home_cfg_id,post_script) VALUES (%s,%s,%s,%s,%s,%s)",(addon_name,url,path,addon_type,home_cfg_id,post_script));


  # print all the first cell of all the rows
  for row in cur.fetchall() :
      print row[0]

insert_addon("Testing addon","www.google.ca","/tmp/","plugin","warsow_win32","touch /tmp/installed.tmp;");
