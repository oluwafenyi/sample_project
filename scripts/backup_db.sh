#!/bin/bash
# postgresql-client pg dump required

DIR=`date +%d-%m-%y`
DEST=~/db_backups/$DIR  # location for dump storage
mkdir -p $DEST

# change credentials to match your db instance
PGPASSWORD='postgres_password' pg_dump --inserts --column-inserts --username=postgres_user --host=postgres_host --port=postgres_port postgres_database_name > dbbackup.sql