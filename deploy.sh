#!/bin/bash

# Variables
GIT_REPO="git@gitlab.com:nour-benkhairia-group/Nour-Benkhairia-project.git"
BRANCH="jo-branch"
IMAGE_NAME="nour/jo-django-app:latest"
LOCAL_DIR="JO"

echo "==== Clonage du projet ===="
# Si le dossier existe, on met à jour, sinon on clone
if [ -d "$LOCAL_DIR" ]; then
    cd "$LOCAL_DIR" || exit
    git fetch origin
    git checkout $BRANCH
    git pull origin $BRANCH
    cd ..
else
    git clone -b $BRANCH $GIT_REPO $LOCAL_DIR
fi

echo "==== Pull de l'image Docker ===="
docker pull $IMAGE_NAME

echo "==== Test du déploiement ===="
docker run --rm -d -p 8000:8000 --name jo-test $IMAGE_NAME

echo "==== Vérification des logs ===="
docker logs -f jo-test

