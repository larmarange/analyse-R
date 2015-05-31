# Introduction à l'analyse d'enquêtes avec R et R Studio

Site consultable à l'adresse <http://larmarange.github.io/analyse-R/>

## Ecriture des chapitres

L'ensemble des chapitres sont écrits en **Rmarkdown** et encodés en UTF-8. 
Le fichier `convention.txt` indique les conventions retenues (typographie, figures,
nom des fonctions, dex extensions, des concepts, encadrés...).

Le nom des fichiers doit être préfixé par `pem_`, `analyses_` ou `avance_`
en fonction de la section où le chapitre sera placé. Par ailleurs,
une fois un chapitre ajouté, il importe de mettre à jour la table des manières,
à la fois dans le fichier `index.Rmd` et dans le fichier `include\before_body.html`.

## Scripts disponibles

Le script **R** `verification_installation_dependances.R` permet de vérifier la présence,
et le cas échéant d'installer, les extensions nécessaires à **analyse-R**.

Le script **R** `make_pdf.R` permet de générer un PDF de l'ensemble du site. Pour cela,
il est nécessaire que le logiciel **Prince XML** soit disponible sur votre machine.
On pourra télécharger **Prinec XML** à <http://www.princexml.com/>.

Le fichier `Makefile` regénérera l'ensemble des pages web du site à partir 
des fichiers sources écrits en **Rmarkdown** puis appelera le script 
`make_pdf.R` pour mettre à jour le PDF du site.

Pour exécuter le fichier `Makefile`, le plus simple consiste à ouvrir 
**analyse-R** avec **RStudio** puis à cliquer sur *Build All* dans 
l'onglet *Build* du quadrant supérieur gauche.

