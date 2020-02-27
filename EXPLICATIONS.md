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
Le gestionnaire de dépendances maven est utilisé pour lancer les commandes de build et de test.

A l'aide d'une pipeline, je souhaite réaliser les tâches suivantes:
 - Build: Je souhaite compiler le projet du répoertoire source "src" et créer un package dans un répertoire cible "target". Je souhaite également compiler et construire la documentation web statique dans "doc", la construction est réalisée à l'aide de maven. Des pages html sont générées et donne accès à la documentation voulue ainsi que les acces aux autres pages. Il est proposé dans le readme de généré une API associé à swagger.
 - Test: Dans ce cas de figure, je souhaite réaliser des tests parallèles sur deux versions de java différents: openjdk8 et openjdk11. Ici passe tout sorte de tests: unitaires, intégration, non-régression, simulation d'erreur.... La commande d'installation fournie permet de passer tous les tests, je souhaite l'utiliser pour les différentes plateformes java pour visualiser la compatibilité et la vitesse d'éxécution.
 - Deploy: Je souhaite déployer la documentation de l'application dans un site web statique sur chaque branche dans le gestionnaire de code source. Une fois le déploiement effectué, je souhaite visualiser le site associé au projet à l'aide de gh-pages associé à l'option github pages. 

 Des travaux de recherche sont effectuer pour trouver comment sont réalisées les pipelines de déploiement dans travis, ainsi que les "jobs" et les méthodes de déploiement. De nombreuses façons de faire les pipelines sont présentées, je souhaite réaliser les tâches par "jobs" pour visualiser le déroulé de l'intégration sur Travis. Seules les commandes indiquées dans les "readme" sont utilisées, étant données que les autres commandes maven ("mvn test", "mvn compile",...) ne fonctionnent pas. 
 
Les étapes de build seules concistent à utiliser la commande indiquée dans le readme, en donnant la commande pour passer les étapes de tests. 

De nombreuses difficultés ont été rencontrées. Notament dans la façon de construire le pipeline sans renvoyer d'erreur et de pour trouver un moyen optimal de déployer la documentation sur un site.






