#!/bin/bash

# Variables
BACKUP_DIR="$HOME/JO/backups"
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
DB_CONTAINER="postgres_db"        # Nom du container PostgreSQL
DB_NAME="mydb"
DB_USER="user"
DB_PASSWORD="password"
MEDIA_VOLUME="myapp_media"       # Nom du volume Docker si tu as des fichiers media

# Créer le dossier de backup s'il n'existe pas
mkdir -p $BACKUP_DIR

echo "==== Backup de la base de données ===="
# Dump de la base PostgreSQL
docker exec -e PGPASSWORD=$DB_PASSWORD $DB_CONTAINER pg_dump -U $DB_USER $DB_NAME > $BACKUP_DIR/db_backup_$DATE.sql

echo "==== Backup des fichiers média (si volume existant) ===="
# Backup du volume média
if docker volume inspect $MEDIA_VOLUME &> /dev/null; then
    docker run --rm -v $MEDIA_VOLUME:/data -v $BACKUP_DIR:/backup alpine tar czf /backup/media_backup_$DATE.tar.gz -C /data .
    echo "Backup du volume media terminé."
else
    echo "Volume media non trouvé, skipped."
fi

echo "==== Backup terminé ===="
echo "Fichiers sauvegardés dans $BACKUP_DIR"

