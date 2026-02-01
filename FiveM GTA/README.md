## Informations

> Pourquoi créer ceci, à quoi cela sert-il ?

Il s’agit simplement d’un fork / d’une modification de l’egg FiveM de [parkervcp](https://github.com/parkervcp), disponible [ici](https://github.com/parkervcp/eggs/tree/master/game_eggs/gta/fivem), que j’utilise pour mes serveurs FiveM.

> Pourquoi devrais-je utiliser celui-ci plutôt qu’un autre egg FiveM ?

Ce fork inclut un moyen simple de mettre à jour les artifacts du serveur, des récupérations automatiques depuis des dépôts Git privés au démarrage du serveur dans le dossier `resources`, ainsi que de nombreuses convars pré-définies pouvant être modifiées depuis la page `Startup` de votre serveur. J’en avais besoin pour mes serveurs et j’ai donc décidé de le partager.

> J’ai une question / pourrais-tu m’aider à le configurer ?

Est-ce que je vais t’aider à le configurer ? Non.  
Cependant, si tu as des questions, je suis généralement disponible sur le [serveur Discord](https://discord.gg/cG5uWvUcM6) orienté FiveM d’un ami, et je serai ravi de répondre à toutes les questions que tu pourrais avoir.

## Mise à jour de l’artifact du serveur

Si tu souhaites mettre à jour l’artifact de ton serveur, un moyen simple est fourni pour le faire.  
Cela supprimera complètement le dossier `alpine` et le remplacera par la version spécifiée ou par la dernière version optionnelle.

1. Sur la page `Startup` de ton serveur, définis `FiveM Version` sur la version vers laquelle tu souhaites mettre à jour.  
   Tu peux également laisser ce champ vide ou le définir sur `latest` pour télécharger la dernière version optionnelle.
2. Sur la page `Settings` de ton serveur, clique sur `Reinstall Server` et confirme.  
   Il ne te reste plus qu’à attendre le téléchargement du nouvel artifact.

## Mise à jour automatique du serveur via Git

Le comportement de Git lorsqu’il est activé est décrit ci-dessous.

### Scénarios au démarrage (au lancement du serveur)

* Si le dossier `resources` est vide, le dépôt spécifié sera cloné dans `resources` au démarrage.
* Si le dossier `resources` contient déjà un dépôt Git, un `git pull` sera exécuté dans `resources` au démarrage.

### Scénarios lors d’une réinstallation  
*(si le bouton `Reinstall Server` est utilisé)*

* Si le dossier `resources` n’existe pas, le dossier sera créé et le dépôt spécifié sera cloné dans `resources` au démarrage.

## txAdmin

txAdmin peut être activé en définissant `TXADMIN_ENABLED` sur `1`.  
N’oublie pas qu’il est également nécessaire de définir `TXADMIN_PORT`.

### Ton serveur ne passera pas en ligne tant qu’il ne sera pas démarré depuis txAdmin.

Bien que txAdmin soit un excellent logiciel, je ne comprends pas l’intérêt d’héberger un serveur sur un panel pour ensuite en utiliser un autre afin de gérer ce même serveur.  
Si tu souhaites utiliser txAdmin, je recommande de rester sur l’egg de [Parkervcp](https://github.com/parkervcp), car la plupart des fonctionnalités supplémentaires de cet egg deviennent redondantes lorsqu’on utilise txAdmin.

## Remarque

La variable `FIVEM_VERSION`.

* Valeur par défaut : `latest`, correspondant à la dernière version optionnelle.
* Peut être définie sur une version spécifique, par exemple :  
  `2431-350dd7bd5c0176216c38625ad5b1108ead44674d`.
* Si le bouton `Reinstall Server` est utilisé, le dossier `alpine` sera remplacé par une version mise à jour.

## Ports du serveur

Ports nécessaires au fonctionnement du serveur, présentés sous forme de tableau.  
Le port txAdmin n’est requis que si tu prévois d’activer txAdmin.

| Port | par défaut |
| - | - |
| Jeu | 30120 |
| txAdmin | 40120 |

## Crédits

* **[Parkervcp](https://github.com/parkervcp)** – *Egg FiveM original* ([lien](https://github.com/parkervcp/eggs/tree/master/game_eggs/gta/fivem)).
* **[Parkervcp](https://github.com/parkervcp)** – *Script Git Clone & Pull* ([lien](https://github.com/parkervcp/eggs/blob/master/scripts/git_cloner.sh)).
* **[Pterodactyl](https://pterodactyl.io/)** – *Créateurs et mainteneurs du panel Pterodactyl.*
* **[Cfx.re](https://fivem.net/)** – *Créateurs et mainteneurs de FiveM et plus encore <3.*
