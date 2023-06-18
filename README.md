# Panoplie
Panoplie est une typographie multi-style générative et modifiable par l'utilisateur.

## Protocole
### 1. Création du module
Dessiner le module dans un logiciel vectoriel de votre choix et l'exporter au format SVG.

![alt text](https://github.com/aurelienmaufroid/panoplie-font/blob/main/documentation/step1.png)


### 2. Générer les lettres
#### A. Choisir ses paramètres
Ouvrir le script Processing `panoplie_alphabet_test` et tester les différents paramètres disponibles.

![alt text](https://github.com/aurelienmaufroid/panoplie-font/blob/main/documentation/step2.2.png)

#### B. Générer avec ses paramètres
Copier les valeurs des paramètres modifiés.<br/>
Ouvrir le script Processing `panoplie_alphabet`.<br/>
Coller les valeurs dans cette partie du script:
```
/////////////////////PARAMETRES A MODIFIER////////////////////////

float xGap = 38, yGap; //XGAP
int maxsize = 58; //TAILLE MAX MODULE
int fontsize = 1000; //CORPS

/////////////////////////////////////////////////////////////////
```
Lancer le script

### 3. Création de la typographie
Importer chaque lettres générées du dossier "EXPORTS" du script dans un logiciel de fonte comme FontForge.

![alt text](https://github.com/aurelienmaufroid/panoplie-font/blob/main/documentation/step3.png)

## Licence
Le projet est sous [LICENCE](https://github.com/aurelienmaufroid/panoplie-font/blob/main/LICENSE) SIL Open Font License v1.1 (http://scripts.sil.org/OFL)
