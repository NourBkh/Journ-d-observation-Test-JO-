#!/bin/bash

GIT_REPO="https://github.com/NourBkh/Journ-d-observation-Test-JO-.git"
BRANCH="main"
IMAGE_NAME="nourbkh/jo:latest"
LOCAL_DIR="JO2"

echo "==== Clonage du projet ===="
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

