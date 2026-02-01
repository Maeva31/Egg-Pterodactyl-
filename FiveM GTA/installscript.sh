#!/bin/ash
# Script d’installation FiveM
#
# Fichiers du serveur : /mnt/server
apt update -y
apt install -y tar xz-utils curl git file jq unzip

mkdir -p /mnt/server
cd /mnt/server

RELEASE_PAGE=$(curl -sSL https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/?$RANDOM)

# Vérifie s’il faut lancer une installation ou une mise à jour
if [ ! -d "./alpine/" ] && [ ! -d "./resources/" ]; then
  # Script d’installation
  echo "Début de l’installation d’un nouveau serveur FiveM."

  # Récupération du lien de téléchargement selon FIVEM_VERSION
  if [ "${FIVEM_VERSION}" == "latest" ] || [ -z ${FIVEM_VERSION} ] ; then
    # Récupère le dernier artifact optionnel si la version est « latest » ou vide
    LATEST_ARTIFACT=$(echo -e "${RELEASE_PAGE}" | grep "LATEST OPTIONAL" -B1 | grep -Eo 'href=".*/*.tar.xz"' | grep -Eo '".*"' | sed 's/\"//g' | sed 's/\.\///1')
    DOWNLOAD_LINK=$(echo https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${LATEST_ARTIFACT})
  else
    # Récupère un artifact spécifique s’il existe
    VERSION_LINK=$(echo -e "${RELEASE_PAGE}" | grep -Eo 'href=".*/*.tar.xz"' | grep -Eo '".*"' | sed 's/\"//g' | sed 's/\.\///1' | grep ${FIVEM_VERSION})
    if [ "${VERSION_LINK}" == "" ]; then
      echo "Version demandée introuvable, téléchargement direct de l’artifact par défaut."
    else
      DOWNLOAD_LINK=$(echo https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${FIVEM_VERSION}/fx.tar.xz)
    fi
  fi

  # Téléchargement de l’artifact et détection du type de fichier
  echo "Exécution de : curl -sSL ${DOWNLOAD_LINK} -o ${DOWNLOAD_LINK##*/}"
  curl -sSL ${DOWNLOAD_LINK} -o ${DOWNLOAD_LINK##*/}
  echo "Extraction des fichiers de l’artifact FiveM..."
  FILETYPE=$(file -F ',' ${DOWNLOAD_LINK##*/} | cut -d',' -f2 | cut -d' ' -f2)

  # Décompression selon le type de fichier
  if [ "$FILETYPE" == "gzip" ]; then
    tar xzvf ${DOWNLOAD_LINK##*/}
  elif [ "$FILETYPE" == "Zip" ]; then
    unzip ${DOWNLOAD_LINK##*/}
  elif [ "$FILETYPE" == "XZ" ]; then
    tar xvf ${DOWNLOAD_LINK##*/}
  else
    echo "Type de fichier inconnu. Arrêt du script."
    exit 2
  fi

  # Suppression de l’ancien script de lancement
  rm -rf ${DOWNLOAD_LINK##*/} run.sh

  if [ -e server.cfg ]; then
    echo "Le fichier server.cfg existe déjà. Téléchargement ignoré."
  else
    echo "Téléchargement du fichier de configuration FiveM par défaut..."
    curl https://raw.githubusercontent.com/darksaid98/pterodactyl-fivem-egg/master/server.cfg >> server.cfg
  fi

  # Clonage des ressources via Git ou installation des ressources par défaut
  if [ "${GIT_ENABLED}" == "1" ] && [ ! -d "/mnt/server/resources" ]; then
    echo "Préparation du clonage des ressources depuis Git."

    if [[ ${GIT_REPOURL} != *.git ]]; then
      GIT_REPOURL=${GIT_REPOURL}.git
    fi

    if [ -z "${GIT_USERNAME}" ] && [ -z "${GIT_TOKEN}" ]; then
      echo "Nom d’utilisateur Git ou token Git non spécifié."
    else
      GIT_REPOURL="https://${GIT_USERNAME}:${GIT_TOKEN}@$(echo -e ${GIT_REPOURL} | cut -d/ -f3-)"
    fi

    if [ -z ${GIT_BRANCH} ]; then
      echo "Clonage de la branche par défaut dans /resources/*."
      git clone ${GIT_REPOURL} /mnt/server/resources
    else
      echo "Clonage de la branche ${GIT_BRANCH} dans /resources/*."
      git clone --single-branch --branch ${GIT_BRANCH} ${GIT_REPOURL} /mnt/server/resources \
        && echo "Clonage terminé avec succès." \
        || echo "Échec du clonage depuis Git."
    fi

  else
    # Installation des ressources FiveM par défaut
    mkdir -p /mnt/server/resources
    echo "Clonage des ressources FiveM par défaut."
    git clone https://github.com/citizenfx/cfx-server-data.git /tmp \
      && echo "Ressources téléchargées depuis Git." \
      || echo "Échec du téléchargement depuis Git."
    cp -Rf /tmp/resources/* resources/
  fi

  mkdir logs/
  echo "Installation terminée."

else
  # Script de mise à jour
  echo "Début de la mise à jour de l’artifact FiveM existant."

  # Suppression de l’ancien artifact
  if [ -d "./alpine/" ]; then
    echo "Suppression de l’ancien artifact..."
    rm -r ./alpine/
    while [ -d "./alpine/" ]; do
      sleep 1s
    done
    echo "Ancien artifact supprimé avec succès."
  fi

  # Récupération du lien de téléchargement
  if [ "${FIVEM_VERSION}" == "latest" ] || [ -z ${FIVEM_VERSION} ] ; then
    LATEST_ARTIFACT=$(echo -e "${RELEASE_PAGE}" | grep "LATEST OPTIONAL" -B1 | grep -Eo 'href=".*/*.tar.xz"' | grep -Eo '".*"' | sed 's/\"//g' | sed 's/\.\///1')
    DOWNLOAD_LINK=$(echo https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${LATEST_ARTIFACT})
  else
    VERSION_LINK=$(echo -e "${RELEASE_PAGE}" | grep -Eo 'href=".*/*.tar.xz"' | grep -Eo '".*"' | sed 's/\"//g' | sed 's/\.\///1' | grep ${FIVEM_VERSION})
    if [ "${VERSION_LINK}" == "" ]; then
      echo "Version demandée introuvable, téléchargement par défaut."
    else
      DOWNLOAD_LINK=$(echo https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${FIVEM_VERSION}/fx.tar.xz)
    fi
  fi

  echo "Téléchargement de l’artifact FiveM..."
  curl -sSL ${DOWNLOAD_LINK} -o ${DOWNLOAD_LINK##*/}
  echo "Extraction des fichiers..."
  FILETYPE=$(file -F ',' ${DOWNLOAD_LINK##*/} | cut -d',' -f2 | cut -d' ' -f2)

  if [ "$FILETYPE" == "gzip" ]; then
    tar xzvf ${DOWNLOAD_LINK##*/}
  elif [ "$FILETYPE" == "Zip" ]; then
    unzip ${DOWNLOAD_LINK##*/}
  elif [ "$FILETYPE" == "XZ" ]; then
    tar xvf ${DOWNLOAD_LINK##*/}
  else
    echo "Type de fichier inconnu. Arrêt."
    exit 2
  fi

  rm -rf ${DOWNLOAD_LINK##*/} run.sh
  echo "Mise à jour terminée."
fi
