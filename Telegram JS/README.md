# Node.js Generic Egg – Pterodactyl

Cet egg **Node.js générique** pour Pterodactyl permet d’exécuter facilement des applications **Node.js** ou **TypeScript** au sein du panel Pterodactyl.  
Il est conçu pour être flexible, compatible avec plusieurs versions de Node.js, et adapté aussi bien aux projets simples qu’aux applications plus avancées (bots Discord, APIs, serveurs, etc.).

---

## Fonctionnalités principales

- Support de **plusieurs versions de Node.js** (20 à 24)
- **Clonage automatique d’un dépôt Git** lors de l’installation
- **Mise à jour automatique du dépôt Git au démarrage** (optionnelle)
- Installation automatique des dépendances (`npm install`)
- Support des fichiers **.js** et **.ts** (via `ts-node`)
- Possibilité d’installer ou désinstaller des packages Node.js via le panel
- Compatible avec des **fichiers uploadés manuellement** par l’utilisateur

---

## Versions Node.js supportées

Les images Docker disponibles pour cet egg sont :

- Node.js 20
- Node.js 21
- Node.js 22
- Node.js 23
- Node.js 24

La version est sélectionnable directement depuis la configuration du serveur dans Pterodactyl.

---

## Installation

1. Importer l’egg **node.js generic** dans votre panel Pterodactyl.
2. Créer un nouveau serveur en utilisant cet egg.
3. Choisir la version de Node.js souhaitée.
4. Configurer les variables de démarrage (voir ci-dessous).
5. Démarrer le serveur.

---

## Fonctionnement de l’installation

### Cas 1 : dépôt Git configuré (recommandé)

- Le dépôt Git est cloné dans `/mnt/server`
- Si un fichier `package.json` est présent :
  - `npm install --production` est exécuté automatiquement
- Les dépendances supplémentaires définies sont installées

### Cas 2 : fichiers uploadés manuellement

- Activer la variable `USER_UPLOAD`
- Le script d’installation est ignoré
- L’utilisateur est responsable de ses fichiers et dépendances

---

## Mise à jour automatique (Git Pull)

Si la variable **AUTO_UPDATE** est activée :

- À chaque démarrage du serveur :
  - Un `git pull` est exécuté automatiquement si un dépôt Git est présent

---

## Variables de configuration

### Arguments & exécution

| Variable | Description |
|--------|------------|
| `MAIN_FILE` | Fichier principal à exécuter (`index.js` ou `.ts`) |
| `NODE_ARGS` | Arguments supplémentaires pour Node.js ou ts-node |

### Git

| Variable | Description |
|--------|------------|
| `GIT_ADDRESS` | URL du dépôt Git à cloner |
| `BRANCH` | Branche à utiliser (vide = branche par défaut) |
| `USERNAME` | Nom d’utilisateur Git (si dépôt privé) |
| `ACCESS_TOKEN` | Token d’accès Git (recommandé pour les dépôts privés) |
| `AUTO_UPDATE` | `1` pour activer le `git pull` automatique au démarrage |

### Dépendances Node.js

| Variable | Description |
|--------|------------|
| `NODE_PACKAGES` | Packages Node.js à installer (séparés par des espaces) |
| `UNNODE_PACKAGES` | Packages Node.js à désinstaller |

### Upload utilisateur

| Variable | Description |
|--------|------------|
| `USER_UPLOAD` | `1` pour ignorer toute l’installation (upload manuel) |

---

## Support TypeScript

- Les fichiers `.ts` sont lancés automatiquement avec **ts-node**
- Les fichiers `.js` sont lancés avec **node**
- Le choix est fait automatiquement selon l’extension du fichier principal

---

## Exemple de configuration simple

```env
MAIN_FILE=index.js
AUTO_UPDATE=1
GIT_ADDRESS=https://github.com/username/mon-projet
BRANCH=main
NODE_PACKAGES=discord.js dotenv
```
# Auteur
- MaEvA  
  - [page GitHub](https://github.com/Maeva31)
  - [Discord](https://discord.gg/bJ4UjhjUDP)
  - [Site Personnel](https://maevakonnect.fr)
