# TP - Introduction au CI/CD 2019/2020

## Stéphane Wilhelm

Durant ma formation TSI, il m'est demandé par notre enseignant d'introduction aux CI/CD Damien Duportal de mettre en oeuvre l'intégration continue sur un projet et dans un langage au choix. Il nous est demandé de créer un processus d'intégration continue avec un projet de notre choix en l'intégrant dans un gestionnaire de code source et construire une "pipeline" de déploiement associé à une plateforme d'intégration continue autre que Jenkins.

Le projet Geoserveur m'a été proposé, il est composé en majorité de scripts java dans ses répertoires. Il s'agit d'un projet code source, c'est-à-dire il peut être librement modifié et redistribué.
Le gestionnaire de code source utilisé est GitHub, il fonctionnalités sont proposés comme le déploiement de sit statique à l'aide du module gh-pages, donnat la possibilité à un projet de déployer une page statique de documentation.
L'intégralité des ressources du projet ont été ajoutés dans un nouveau projet que j'ai créé.

L'outil d'intégration continue Travis a été réutilisé pour réaliser ce travail. Il fournit un service en ligne pour pouvoir compiler, tester et déployer le code source du projet, à l'aide d'une pipeline à configurer, dévrivant les différentes étapes d'intégration. Le pipeline est écrit dans un langage balisé YAML ".yml", le fichier permettant de déployer la pipeline lors d'un commit de projet dans GitHub est ".travis.yml". Le compte GitHub peut être associé à travis: en cas de commit, un build est lancé.

Damien Duportail a été ajouté en tant que contributeur pour lui permettre de regarder le code et le déroulement de la construction de ma pipeline, il doit avoir l'accès administrateur au contenu du projet. Il devra faire des "Pull/Merge Request" pour tester le bon fonctionnement des tests.

Les composants suivant du projet devront être manipulés:
 - le code source src, où devront être effectués le build et les test de l'application
 - la documentation doc, où est déployée un site statique html de documentation du projet, c'est celui ci qui devra être construit et déployé sur chaque branche du projet.










