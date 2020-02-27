# TP - Introduction au CI/CD 2019/2020

réalisé par Stéphane Wilhelm

### Introduction

Durant ma formation TSI, il m'est demandé par notre enseignant d'introduction aux CI/CD Damien Duportal de mettre en oeuvre l'intégration continue sur un projet et dans un langage au choix. Il nous est demandé de créer un processus d'intégration continue avec un projet de notre choix en l'intégrant dans un gestionnaire de code source et construire une "pipeline" de déploiement associé à une plateforme d'intégration continue autre que Jenkins.
Les consignes du TP sont disponibles dans le lien suivant:
https://docs.google.com/document/d/1AtPzhCsW8xluITJSaSAqPFqPqhV54bwET__e3fIshHE/edit#

### Préparation

Le projet Geoserveur m'a été proposé, il est composé en majorité de scripts java dans ses répertoires. Il s'agit d'un projet code source, c'est-à-dire il peut être librement modifié et redistribué.
Le gestionnaire de code source utilisé est GitHub, où différentes fonctionnalités sont proposés comme le déploiement de site statique à l'aide du module gh-pages, dont la possibilité à un projet de déployer une page statique de documentation.
L'intégralité des ressources du projet ont été ajoutés dans un nouveau projet que j'ai créé dans GitHub.

L'outil d'intégration continue Travis CI a été réutilisé pour réaliser ce travail. Il fournit un service en ligne pour pouvoir compiler, tester et déployer le code source du projet, à l'aide d'une pipeline à configurer, dévrivant les différentes étapes d'intégration. Le pipeline est écrit dans un langage balisé YAML ".yml", le fichier permettant de déployer la pipeline lors d'un commit de projet dans GitHub est ".travis.yml". Le compte GitHub peut être associé à travis: en cas de modification et d'un commit, un build est lancé.

Damien Duportal a été ajouté en tant que contributeur pour lui permettre de regarder le code et le déroulement de la construction de ma pipeline, il doit avoir l'accès administrateur au contenu du projet. Il devra faire des "Pull/Merge Request" pour vérifier le bon fonctionnement des tests.

Les composants suivant du projet devront être manipulés:
 - le code source src, où devront être effectués le build et les test de l'application
 - la documentation doc, où est déployée un site statique html de documentation du projet, c'est celui ci qui devra être construit et déployé sur chaque branche du projet.
Le gestionnaire de dépendances maven est utilisé pour lancer les commandes de build et de test.

A l'aide d'une pipeline, je souhaite réaliser les tâches suivantes:
 - Build: Je souhaite compiler le projet du répoertoire source "src" et créer un package dans un répertoire cible "target". Je souhaite également compiler et construire la documentation web statique dans "doc", la construction est réalisée à l'aide de maven. Des pages html sont générées et donne accès à la documentation voulue ainsi que les acces aux autres pages. Il est proposé dans le readme de généré une API associé à swagger.
 - Test: Dans ce cas de figure, je souhaite réaliser des tests parallèles sur deux versions de java différents: openjdk8 et openjdk11. Ici passe tout sorte de tests: unitaires, intégration, non-régression, simulation d'erreur.... La commande d'installation fournie permet de passer tous les tests, je souhaite l'utiliser pour les différentes plateformes java pour visualiser la compatibilité et la vitesse d'exécution.
 - Deploy: Je souhaite déployer la documentation de l'application dans un site web statique sur chaque branche dans le gestionnaire de code source. Une fois le déploiement effectué
 L'objectif du tp est de faire fonctionner les différentes tâches de la pipeline et d'être en mesure de réussir et échouer si voulu en cas de modification de test.

### Déroulement

 Des travaux de recherche étaient à effectuer pour trouver comment sont réalisées les pipelines de déploiement dans travis, ainsi que les "jobs" et les méthodes de déploiement. De nombreuses façons de faire les pipelines sont présentées, je souhaite réaliser les tâches par "jobs" pour visualiser le déroulé de l'intégration sur Travis. Seules les commandes indiquées dans les "readme" sont utilisées, étant données que les autres commandes maven ("mvn test", "mvn compile",...) ne fonctionnent pas. Il a fallut du temps pour me familiariser avec l'environnement et à comprendre comment pouvaient être organisées les balises et les composants de la pipeline.

Plusieurs méthodes ont été testées et employées pour déployer le pipeline, je pensait à la base faire les étapes "à la racine"(sans l'inclure dans des "jobs") et tout effectuer en parallélisme avec jdv8 et jdk11, en exécutant simplement la commande "mvn simple install" mais j'ai préféré exclure le parallélise à l'étape de test, voyant qu'il était possible de le faire dans un "stage" de Travis. je peut écrire "jdk:" pour chaque "name" de la tâche "stage". Ainsi, je n'ai pas besoin de déployer deux fois la documentation.

Les temps de build et d'intégration pouvaient être très longs (environs 45 minutes pour une intégration complète). Beaucoup de temps peut passer pour vérifier si une correction est valide, m'obligeant à trouver des méthodes pour raccourcir les temps de build, comme par exemple, faire les tests sur une sous partie du code source (wfs, wms...) pour vérifier le bon fonctionnement d'un paramètre saisie. Je pensait même remplacer les commandes de build par des "echo" ou sauter des étapes de "build" et "test" pour éviter les build prenant un temps conséquent dans le simple but de tester si un paramètre renseigné dans le pipeline ou sur github fonctionne. Il y a une quantité conséquente de tests à effectué sur l'ensemble du projet, regroupés en 37 grandes étapes faisant des tests sur les nombreux composants.

Les étapes de build seules consistent à utiliser la commande indiquée dans le fichier readme, en donnant la commande pour passer les étapes de tests.
Lors du build, j'avais des erreurs qui n'étaient pas vraiment compréhensibles dans la console du build, par exemple, lors du lancement de la phase "deploy", j'avais comme message d'erreurs "'build.xml' not found". Alors qu'il fallait en fait se mettre dans le répertoire "src" où un fichier pom.xml est situé pour lancer des commandes maven au lieu de ant. De même lors de la phase de déploiement, le déployement était lancé et échouais aussitôt sans message d'erreur.

La pipeline devait être construite de manière optimale sans renvoyer de message d'erreur.
Pour le déploiement, je devais trouver une méthode en utilisant travis sans renvoi d'erreur. Le tocken github est utilisé pour effectuer des opération à travers html, et donc déployer le site statique voulu.
Les tests pouvaient échouer de manière inexpliquées, me faisant dire qu'il y a des problèmes dans les codes de tests ou même à l'intérieur de la pipeline.

L'outil gh-pages est proposé pour déployer sous forme de site web la documentation du projet. En raison d'un problème de lecture de yaml dans un des fichiers du déploiement site, il était impossible de trouver la source de l'erreur et de la corriger sans tenter de modifier des lignes balisées au sein d'un fichier. Il était indiqué une erreur de syntaxe qui ne semblait pas avoir lieu à ma connaissance après vérification.
Il s'agit d'une erreur du type accolade manquante dans un des fichiers YAML "''}}'' is missing" alors qu'à l'intérieur du fichier, les valeurs sont balisées correctement (voir image dans le répertoire).
Les token ont été créés sur github et rentrés en tant que variable globale dans les paramètres de build de travis pour vérifier le bon fonctionnement de l'étape deploy lors du build.
De point de vue global, le stage build et test sont fonctionnels, mais je n'ai pas réussi, malgré plusieurs tentatives, à faire fonctionner l'étape de déploiement vers une page web statique sur plusieurs branches. J'aurais aimé vérifier le bon fonctionnement du déploiement pour m'assurer du bon fonctionnement du site web statique et exploiter en profondeur les outils et fonctionnalités proposées par GitHub et Travis.

### Conclusion

Malgré les difficultés rencontrées, ce TP m'a permis de comprendre le fonctionnent de l'intégration continue et son utilité pour le déploiement de logiciel afin de garantir son bon fonctionnent et de savoir au plus vite si des erreurs peuvent se produire après le une modification où un ajout de fonctionnalité. Le déploiement continue est une pratique qui s'acquiert par les membres d'une équipe de développement pour faciliter leur travail et éviter de déployer des solutions non fonctionnelles à destination des clients, cette méthode demande de maîtriser les outils permettant d'intégrer la solution de manière correcte. Il y a besoin d'un gestionnaire de code source, de branches, d'une plateforme d'intégration continue et d'une organisation commune au sein d'une équipe de développeur étant à l'aide avec les outils de déploiement continue. Le principe de pipeline est "d'industrialiser" la solution logicielle et de découper en plusieurs étapes les étapes avant une livraisons dans le but de trouver l'endroit où il y a des réparations à faire en cas de problème. Il existe une multitude d'outils et des méthodes d'intégration pour déployer des solutions logicielles de manière optimales qui correspondent au mieux aux attentes des destinataires.
