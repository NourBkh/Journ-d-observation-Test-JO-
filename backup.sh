#!/bin/bash


BACKUP_DIR="$HOME/JO2/backups"
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
DB_CONTAINER="postgres_db"        
DB_NAME="mydb"
DB_USER="user"
DB_PASSWORD="password"
      


mkdir -p $BACKUP_DIR

echo "==== Backup de la base de données ===="
# Dump de la base PostgreSQL
docker exec -e PGPASSWORD=$DB_PASSWORD $DB_CONTAINER pg_dump -U $DB_USER $DB_NAME > $BACKUP_DIR/db_backup_$DATE.sql

echo "==== Backup terminé ===="
echo "Fichiers sauvegardés dans $BACKUP_DIR"

