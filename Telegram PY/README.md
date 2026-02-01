# Python Generic Egg – Pterodactyl

Cet **egg Python générique** pour **Pterodactyl / Pelican** permet d’exécuter facilement tout type d’application Python :  
bot (Discord, Telegram…), API, script automatisé ou application serveur.

Il est conçu pour être **simple, flexible et compatible avec de nombreuses versions de Python**.

---

## Fonctionnalités

- Support de **Python 2.7 à Python 3.14**
- Clonage automatique d’un **dépôt Git** à l’installation
- **Mise à jour automatique (git pull)** au démarrage (optionnelle)
- Installation automatique des dépendances Python
- Support des **requirements.txt personnalisés**
- Possibilité d’installer des packages Python supplémentaires
- Mode **upload manuel** pour utilisateurs avancés

---

## Versions Python supportées

Images Docker disponibles :

- Python 3.14
- Python 3.13
- Python 3.12
- Python 3.11
- Python 3.10
- Python 3.9
- Python 3.8
- Python 3.7
- Python 2.7

La version se choisit directement dans la configuration du serveur sur le panel.

---

## Installation

1. Importer l’egg **python generic** dans le panel Pterodactyl.
2. Créer un nouveau serveur avec cet egg.
3. Sélectionner la version de Python souhaitée.
4. Configurer les variables de démarrage (voir ci-dessous).
5. Démarrer le serveur.

---

## Fonctionnement de l’installation

### Avec dépôt Git (recommandé)

- Le dépôt est cloné dans `/mnt/server`
- Si un fichier `requirements.txt` est présent :
  - les dépendances sont installées automatiquement
- Les packages définis dans `PY_PACKAGES` sont installés

### Avec fichiers uploadés manuellement

- Activer `USER_UPLOAD`
- Le script d’installation est ignoré
- L’utilisateur gère lui-même ses fichiers et dépendances

---

## Mise à jour automatique (Git)

Si **AUTO_UPDATE** est activé :

- À chaque démarrage du serveur :
  - un `git pull` est exécuté automatiquement si un dépôt Git est présent

---

## Variables de configuration

### Exécution Python

| Variable | Description |
|--------|------------|
| `PY_FILE` | Fichier Python principal à exécuter |
| `REQUIREMENTS_FILE` | Fichier de dépendances (ex: `requirements.txt`) |

### Dépendances Python

| Variable | Description |
|--------|------------|
| `PY_PACKAGES` | Packages Python supplémentaires à installer (séparés par des espaces) |

### Git

| Variable | Description |
|--------|------------|
| `GIT_ADDRESS` | URL du dépôt Git à cloner |
| `BRANCH` | Branche à utiliser (vide = branche par défaut) |
| `USERNAME` | Nom d’utilisateur Git |
| `ACCESS_TOKEN` | Token d’accès Git (recommandé pour dépôts privés) |
| `AUTO_UPDATE` | `1` pour activer la mise à jour automatique au démarrage |

### Upload manuel

| Variable | Description |
|--------|------------|
| `USER_UPLOAD` | `1` pour ignorer toute l’installation automatique |

---

## Exemple de configuration simple

```env
PY_FILE=bot.py
AUTO_UPDATE=1
GIT_ADDRESS=https://github.com/username/mon-bot-python
BRANCH=main
PY_PACKAGES=discord.py python-dotenv
REQUIREMENTS_FILE=requirements.txt
```
# Auteur
- MaEvA  
  - [page GitHub](https://github.com/Maeva31)
  - [Discord](https://discord.gg/bJ4UjhjUDP)
  - [Site Personnel](https://maevakonnect.fr)
