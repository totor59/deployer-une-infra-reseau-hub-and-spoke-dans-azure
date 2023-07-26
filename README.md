# Déployer une infra réseau Hub-and-Spoke dans Azure

L'objectif est de provisionner un environnement semblable aux environnements de production en entreprise.
La finalité est de comprendre les interactions des différents composants de l'architecture : réseau, infrastructure, application
Le déploiement pourra être : manuel ou automatique (partiellement ou totalement).
Le choix de la technologie employé est libre : ARM, Terraform, etc.

## Contexte du projet
En tant que admin DevOps, déployer une infra réseau Hub-and-Spoke dans Azure contenant:

Un VNET Hub avec un Firewall OpnSense pour gérer le routage et le filtrage entre les subnet Utiliser le template fournit pour automatiser l'installation https://github.com/dmauser/opnazure

Un VNET Spoke avec un subnet unique pour héberger un client Windows 10

Configurer le peering avec le VNET-HUB
Un VM spoke avec deux subnets pour héberger:

Configurer le peering avec le VNET-HUB
un load-balancer avec IP interne uniquement
deux serveurs web avec IP interne uniquement (et une page de démo sur le port 80)
créer une table de routage à appliquer sur les subnet Spoke pour forcer le routage par le FW https://learn.microsoft.com/en-us/azure/virtual-network/manage-route-table Route:

Name : default

Address prefix: 0.0.0.0/0

Next hop type : Virtual appliance

Next hop IP address : 

> Note : Attention les accès à partir des IP publiques des VM ne fonctionneront plus une fois la table de routage appliquée (routage asymétrique)

Configurer le firewall

Configurer les routes statiques pour le routage interne Azure System > Routes > Configuration :
Network address: 10.0.0.0/8
Gateway :
Autoriser l'accès internet uniquement pour les postes Windows 10 (SNET-CLIENT)
Autoriser l'accès depuis internet au load-balancer (NAT du port 80)
Autoriser l'accès au poste Windows 10 depuis internet (NAT du port 3389)
Plan d'adressage:

- VNET-HUB : 10.120.0.0/22
- SNET-FW-EXT : 10.120.0.0/28
- SNET-FW-INT : 10.120.0.16/28
- VNET-CLIENT : 10.120.4.0/22
- SNET-CLIENT : 10.120.4.0/24
- VNET-SERVER : 10.120.8.0/22
- SNET-SERVER : 10.120.8.0/24
- SNET-LB : 10.120.9.0/24

## Modalités pédagogiques
Travail en groupe pour l'ensemble de la promotion : partager au maximum les savoirs individuels pour faire progresser le collectif.

## Modalités d'évaluation
- Le bon fonctionnement le l'infrastructure cible
- la capacité à décrire l'environnement et la configuration réalisées
- la lucidité sur les problèmes et blocages rencontrés

## Livrables
Un environnement Azure fonctionnel:
- le client Windows 10 doit pouvoir accéder à internet avec une IP source correspondant à celle du Firewall (whatismyip.net)
- les serveurs web n'ont pas accès internet
- le site web est accessible depuis internet sur le port 80 depuis l'IP publique du firewall

## Critères de performance
Avoir compris les enjeux, les concepts techniques
Ressentir la difficulté face à la combinaison d'éléments techniques diverses, complexes et non maîtrisés
Prendre connaissance de ses limites et identifier ses axes d'amélioration