Nouveautés
===========

Version 1.3 du 18 mai 2015
--------------------------
Améliorations :
- modification de l'affichage des analyses d'eau
- ajout d'une colonne de débit d'eau dans les analyses d'eau et de la saisie des métaux lourds
- ajout de la gestion de l'alimentation des juvéniles traités par lots (stade post-larve)

Corrections de bogues :
- correction d'un problème de droits dans l'accès à la saisie des analyses des circuits d'eau
- corrections de libellés
- corrections d'anomalies liées au mode développement/production
- correction de la navigation dans le module de gestion de la campagne de reproduction, pour un poisson

Version 1.2.1 du 20 avril 2015
------------------------------
Correction d'un bug lors de la génération d'une nouvelle répartition : le numéro de la répartition précédente n'était pas restranscrit

Version 1.2 du 14 avril 2015
---------------------------------
Création du module de gestion de la reproduction
- première version opérationnelle

Améliorations :
- pour améliorer la performance, la liste des poissons s'affiche par défaut sans les mensurations, activables manuellement
- à partir de la liste des poissons, il est possible de générer un fichier CSV comprenant l'ensemble des événements pour les poissons sélectionnés
- les échographies peuvent être renseignées directement lors de la saisie d'un événement, les photos pouvant y être associées directement

Corrections de bogues :
- affichage des listes : le survol par la souris colore la ligne considérée
- rajout d'une fonction dans ObjetBDD permettant de limiter les risques d'injection SQL, et modification de l'ensemble des classes pour gérer cet aspect (requêtes de sélection portant sur des chaînes de caractères)

Version 1.1.3
-------------
Correction d'un bogue : 
- les valeurs nulles dans l'écran de saisie des répartitions d'aliments généraient des anomalies dans les données.

Version 1.1.2 du 4 septembre 2014
---------------------------------
Correction d'un bogue :
- lors de la duplication des feuilles de distribution, les bassins qui sont devenus inactifs, ou dont le type de poisson élevé a changé (adulte -> juvénile) sont exclus de la nouvelle feuille
Évolutions mineures : 
- la liste des poissons affichée dans l'écran de recherche intègre maintenant le dernier bassin et les dernières mensurations connus
- dans l'affichage d'un bassin, la masse individuelle et totale des poissons a été rajoutée à la liste

Version 1.1.1 du 31 juillet 2014
--------------------------------
Correction de bogues et évolutions mineures :
- il était impossible de créer un nouveau poisson (problème lié à l'enregistrement du sexe)
- les personnes disposant du droit poissonAdmin n'avaient pas la possibilité de supprimer un poisson ou un événement. La correction a été également apportée à l'ensemble des pages de modifications incluant un bouton supprimer (vérification des droits nécessaires)
- création d'un script permettant de supprimer un poisson de façon propre. Le poisson ne sera pas supprimé s'il existe des événements, ou si le poisson a des descendants déclarés. Une fois ces contrôles effectués, la suppression gère l'effacement des pittag et des documents associés
- la fiche "alimentation juvénile" a été basculée en format paysage. Le total des aliments distribués sur une semaine est maintenant calculé systématiquement sur 7 jours, quelle que soit le nombre de jours de validité de la fiche
- rajout d'une colonne commentaire dans le poisson, pour saisir des informations qui ne peuvent être stockées ailleurs

Version 1.1 du 18 juin 2014
---------------------------
Correction de bogues :
- le calcul des aliments distribués quotidiennement était erroné dans le cas où une distribution n'avait pas lieu un jour donné
- après duplication d'une feuille de distribution, le programme refusait d'afficher la feuille en modification
Rajout de fonctionnalités concernant la distribution :
- rajout d'une zone permettant d'indiquer une distribution à 50 % certains jours
- recalcul des restes et des taux de restes en prenant en compte les valeurs réellement rentrées quotidiennement, et non plus les informations de la distribution précédente

Version 1.0.1 du 20 mai 2014
----------------------------
Version de production, comportant les corrections suivantes :
- modification d'un poisson : il est maintenant possible de changer sa catégorie (juvénile, adulte...)
- Saisie des répartitions : les modèles de distribution des aliments sont maintenant triés par nom, et non plus par date de création
- correction du changement de statut lors de l'enregistrement d'un événement "mortalité"
- Durée de la session : en l'absence de toute opération dans l'application, l'utilisateur est déconnecté au bout d'une heure (au lieu de 4 auparavant). Il s'agit d'une exigence de sécurité du RGS
- Correction d'un élément du framework (ObjetBDD)


Version 1.0 du 6 mai 2014
-------------------------
Version initiale de pré-production