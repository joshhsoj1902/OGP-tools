#!/usr/bin/python
import MySQLdb
import getpass
import csv
import time
import os

database = ""
database_host = "localhost"
database_user = "root"
database_password = ""
database_name = "opengamepanel"

def update_addon(addon_name,url,path,addon_type,game_key,post_script):
  remove_addon(addon_name,game_key)
  insert_addon(addon_name,url,path,addon_type,game_key,post_script)

#addon_name           #Readable Name for the Addon
#url                  #URL to the item to download
#path                 #Local path to put the downloaded file (Must be relitave to game root, can't start or end with /)
#addon_type           #plugin,mappack,config
#home_cfg_id          #Int id of the game server found in ogp_config_homes
#post_script          #Full bash script of the command to run after downloading
def insert_addon(addon_name,url,path,addon_type,game_key,post_script):

  global database 

  home_cfg_id = get_home_config_id(game_key)
  cur = database.cursor() 

  cur.execute("INSERT INTO ogp_addons (name,url,path,addon_type,home_cfg_id,post_script) VALUES (%s,%s,%s,%s,%s,%s)",(addon_name,url,path,addon_type,home_cfg_id,post_script));

def remove_addon(addon_name,game_key):

  global database

  home_cfg_id = get_home_config_id(game_key)
  cur = database.cursor()

  cur.execute("SELECT * FROM ogp_addons WHERE home_cfg_id=%s AND name=%s",(home_cfg_id,addon_name))
  backup_addon(cur,addon_name)

  cur.execute("DELETE FROM ogp_addons WHERE home_cfg_id=%s AND name=%s",(home_cfg_id,addon_name));

def backup_addon(cursor,addon_name):

  backup_dir = "backups"
  if not os.path.exists(backup_dir):
    os.makedirs(backup_dir)

  filename = backup_dir + "/" + addon_name + "-" + time.strftime("%Y%m%d-%H%M%S") + ".csv"
  
  with open(filename, "wb") as csv_file:
    csv_writer = csv.writer(csv_file)
    csv_writer.writerow([i[0] for i in cursor.description]) # write headers
    csv_writer.writerows(cursor)



def get_home_config_id(game_key):
  open_database()  
  global database

  cur = database.cursor()  
  cur.execute("SELECT home_cfg_id FROM ogp_config_homes WHERE game_key=%s",game_key)

  # print all the first cell of all the rows
  for row in cur.fetchall() :
      #Use only the first returned
      home_cfg_id = row[0]

  return home_cfg_id

def prompt_password():

  password =  database_password = getpass.getpass(prompt='Enter root DB password:')
  return password

def open_database():

  global database_host
  global database_user
  global database_password
  global database_name

  if not database_password:
    database_password = prompt_password()

  db = open_database_connection(database_host,database_user,database_password,database_name)

def open_database_connection(host,user,password,db):

  global database
  database = MySQLdb.connect(host="localhost", # your host, usually localhost
                       user="root", # your username
                       passwd=password, # your password
                       db="opengamepanel") # name of the data base
