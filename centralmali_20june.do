
/*address - central mali project 
20th July presentation - (15th May due date)
code - shourjya*/ 


cd  "C:\Users\Shourjya Deb\ownCloud\shourjya_central mali\data_analysis_restitution"


//data import
import excel "C:\Users\Shourjya Deb\ownCloud\shourjya_central mali\data_analysis\BASEQ6.xlsx", sheet("BASEQ6") firstrow


//name of the respondent Q1_2
tab Q1_2
duplicates report Q1_2

clonevar name=Q1_2
count if Q1_1==""

sort name

**3 observations do not have name - missing value for name



//gender of the respondent - Q1_12
tab Q1_12
codebook Q1_12

generate gender=.
//1 male, 2 female 

replace gender=1 if Q1_12=="Masculin"
replace gender=2 if gender==.

label define gender_label 1 "Male" 2 "Female"
label values gender gender_label

codebook gender


//region  Q1_3

tab Q1_3
codebook Q1_3

//1 Segou 2 Mopti 
generate region=. 
replace region=1 if Q1_3=="Ségou"
replace region=2 if region==. 

tab region 

label define region_label 1 "Ségou" 2 "Mopti"
label values region region_label 

codebook region 
tab region


tab region gender, row

//age grouops Q1_13
tab Q1_13
generate age_groups=. 
//1 adult >35, 2 youth<=35

replace age_groups=1 if Q1_13>35
replace age_groups=2 if Q1_13<=35

label define age_label 1 "adult" 2 "youth"
label values age_groups age_label 

codebook age_groups

tab age_groups 

tab age_groups gender, row

//urban-rural break up - Q1_7

tab Q1_7
codebook Q1_7

generate residence=. 
//1-urban 2- rural 
replace residence=1 if Q1_7=="Urbain"
replace residence=2 if Q1_7=="Rural"

label define res_label 1 "Urban" 2 "Rural"
label values residence res_label 

codebook residence 

tab residence gender, row


//literacy - Q1_14_A

tab Q1_14_A
codebook Q1_14_A

/*
1 = Non alphabétisé ;
2 = Fondamental premier cycle ;
3 = Fondamental second cycle ;
4 = Secondaire ;
5 = Supérieur (université)
*/


generate lit_lvl=. 
replace lit_lvl=1 if Q1_14_A=="Non-alphabétisé"
replace lit_lvl=2 if Q1_14_A=="Fondamenatal premier cycle"
replace lit_lvl=3 if Q1_14_A=="Fondamental second cycle"
replace lit_lvl=4 if Q1_14_A=="Secondaire"
replace lit_lvl=5 if Q1_14_A=="Supérieur (Université)"


label define lit_labels 1 "Non-literate" 2 "Fundamental premier cycle" 3 "Fundamental second cycle" 4 "Secondary" 5 "University"
label values lit_lvl lit_labels 

codebook lit_lvl

tab lit_lvl

generate lit_cat=.
replace lit_cat=1 if lit_lvl==1
replace lit_cat=2 if lit_lvl>1

tab lit_cat

label define litcat_labels 1 "Non-literate" 2 "literate"
label values lit_cat litcat_labels

codebook lit_cat

tab lit_cat gender, row 

tab lit_cat
tab lit_lvl

//displaced persons - Q1_11_A

tab Q1_11_A
generate res_status=. 
replace res_status=1 if Q1_11_A=="Déplacé (malien)"
replace res_status=2 if Q1_11_A=="Résident"
replace res_status=3 if Q1_11_A=="Rétourné"

label define res_labels 1 "Displaced(Maliean)" 2 "Resident" 3 "Returned"
label values res_status res_labels

codebook res_status 

tab res_status

tab res_status gender, row


//governance indicators 

//level of trust on actors - question Q2_3_1-Q2_3_15

rename Q2_3_1 con_loc
rename Q2_3_2 con_pre
rename Q2_3_3 con_subpre
rename Q2_3_4 con_hov
rename Q2_3_5 con_jud
rename Q2_3_6 con_ngo 
rename Q2_3_7 con_custch
rename Q2_3_8 con_relled
rename Q2_3_9 con_fama
rename Q2_3_10 con_gend
rename Q2_3_11 con_pol
rename Q2_3_12 con_minusma
rename Q2_3_13 con_ng
rename Q2_3_14 con_barkhane
rename Q2_3_15 con_sd



label variable con_loc "Les élus locaux"
label variable con_pre "Les préfets"
label variable con_subpre "Les sous-préfets"
label variable con_hov "Le chef de village/quartier"
label variable con_jud "Les juges et magistrats"
label variable con_ngo "Les organisations non gouvernementales"
label variable con_custch "Les chefs coutumiers"
label variable con_relled "Les chefs religieux"
label variable con_fama "FAMA"
label variable con_gend "Gendarmerie"
label variable con_pol "Police"
label variable con_minusma "MINUSMA"
label variable con_ng "Garde nationale"
label variable con_barkhane "Barkhane"
label variable con_sd "Groupe d’autodéfense"


tab con_loc
tab con_sd

/*Indiquez votre niveau de confiance dans les acteurs suivants :
Code : 1= Pas de confiance ; 2= Peu de confiance (parfois) ; 
3= Confiance (souvent) ; 4= Beaucoup de confiance (toujours) ; 
5= Je ne connais pas l’acteur ; 6= Pas possible de poser la question.

Indicate your level of confidence in the following actors:
Code: 1= No confidence; 2= Little confidence (sometimes); 
3= Confidence (often); 4= A lot of confidence (always); 
5= Don't know the actor; 6= Can't ask the question.*/

count if con_sd=="Pas possible de poser la question"

label define con_lab 1 "Pas de confiance" 2 "Peu de confiance (parfois)" 3 "Confiance (souvent)" 4 "Beaucoup de confiance (toujours)" 5 "Je ne connais pas l'acteur" 6 "Pas possible de poser la question"


foreach var of varlist con_loc-con_sd {

replace `var'="1" if `var'=="Pas de confiance"
replace `var'="2" if `var'=="Peu de confiance (parfois)"
replace `var'="3" if `var'=="Confiance (souvent)"
replace `var'="4" if `var'=="Beaucoup de confiance (toujours)"
replace `var'="5" if `var'=="Je ne connais pas l'acteur"
replace `var'="6" if `var'=="Pas possible de poser la question"

destring `var', replace
label values `var' con_lab
}


//
foreach var of varlist con_loc-con_sd {
codebook `var', tab(100)
}




save temp_baseq6

//getting the results out for tableau 
use temp_baseq6


tab con_loc

foreach var of varlist con_loc-con_sd {
tabout `var' using con_data.xls, c(col) append
}

tabout con_loc using Nik.xls, c(col) append


//trust on justice system  Q4_3

generate justice_system=. 
replace justice_system=1 if Q4_3=="Aucun de ceux-là"
replace justice_system=2 if Q4_3=="Le système coutumier"
replace justice_system=3 if Q4_3=="Le système religieux"
replace justice_system=4 if Q4_3=="Le système étatique (tribunal)"

label define jus_label 1 "Aucun de ceux-là" 2 "Le système coutumier" 3 "Le système religieux" 4 "Le système étatique (tribunal)"
label values justice_system jus_label 

codebook justice_system 

tab justice_system

codebook region 

tab justice_system region, row 


tab justice_system age_groups, row 



tabout justice_system jussys_data.xls, row 
tabout justice_system region jussys_data.xls, c(col) append row 
tabout justice_system age_groups jussys_data.xls, c(col) append row 


tab justice_system
return list
tabulate justice_system, matcell(freq) matrow(names)


//for disaggregation by cercle 
//cercel names for mopti unavilable - use codes below to identify them 
/*
10 - Bankass
11 - Djenné
12 - Douentza
13 - Koro
14 - Tenenkou
15 - Youwarou
8 - Mopti
9 - Bandiagar
*/  

//cercle question - Q1_4

tab Q1_4
generate cercle="." 
move Q1_4 cercle

/*
replace cercle=8 if Q1_4=="Mopti"
replace cercle=9 if Q1_4=="Bandiagar"
replace cercle=10 if Q1_4=="Bankass"
replace cercle=11 if Q1_4=="Djenné"
replace cercle=12 if Q1_4=="Douentza"
replace cercle=13 if Q1_4=="Koro"
replace cercle=14 if Q1_4=="Tenenkou"
replace cercle=15 if Q1_4=="Youwarou"
*/

replace cercle="1" if Q1_4=="Baraoueli"
replace cercle="2" if Q1_4=="Bla"
replace cercle="3" if Q1_4=="Macina"
replace cercle="4" if Q1_4=="Niono"
replace cercle="5" if Q1_4=="San"
replace cercle="6" if Q1_4=="Ségou"
replace cercle="7" if Q1_4=="Tominian"

replace cercle="8" if Q1_4=="8"
replace cercle="9" if Q1_4=="9"
replace cercle="10" if Q1_4=="10"
replace cercle="11" if Q1_4=="11"
replace cercle="12" if Q1_4=="12"
replace cercle="13" if Q1_4=="13"
replace cercle="14" if Q1_4=="14"
replace cercle="15" if Q1_4=="15"

destring cercle, replace 

label define cer_lab 1 "Baraoueli" 2 "Bla" 3 "Macina" 4 "Niono" 5 "San" ///
6 "Ségou" 7 "Tominian" 8 "Mopti" 9 "Bandiagar" 10 "Bankass" 11 "Djenné" ///
12 "Douentza" 13 "Koro" 14 "Tenenkou" 15 "Youwarou" 


label values cercle cer_lab 

tab justice_system 
tab justice_system cercle, row  

move region cercle
move justice_system cercle 

save, replace 

use temp_baseq6

sort Q1_0_B

tab justice_system 
tab justice_system cercle
tab justice_system cercle 

tab region cercle

tab Q6_5_A
tab Q6_5_B

generate prob_fieldwork=Q6_5_B
tab prob_fieldwork


tab Q7_5_A
tab Q7_5_B 


generate prob_husb=Q7_5_B
tab prob_husb

tab Q6_6
generate crop_use=Q6_6
tab crop_use


tab Q7_4
generate husb_use=Q7_4
tab husb_use

tab Q8_3
generate fish_use=Q8_3
tab fish_use

/*Facile 1
 Pas de changement 2
Un peu difficle 3 
Très difficile 4
Impissble  5
*/


tab Q9_3
generate market_access="."
replace market_access="1" if Q9_3=="Facile"
replace market_access="2" if Q9_3=="Pas de changement"
replace market_access="3" if Q9_3=="Un peu difficile"
replace market_access="4" if Q9_3=="Très difficile"
replace market_access="5" if Q9_3=="Impossible"

destring market_access, replace

label define market_labels 1 "Facile" 2 "Pas de changement" 3 "Un peu difficile" ///
4 "Très difficile" 5 "Impossible"

label values market_access market_labels 

save, replace

asdoc tab region market_access, row

asdoc tab residence market_access, row

clear


tab Q9_4


generate market_prob="."

/*
1 = Manque de clients ;
2 = Augmentation des prix;
3 = Limitation des déplacements (barrages) ;
4 = Insécurité (vol, braquage) ;
5 = Manque de moyens de transports ;
6 = Fermeture des foires et marchés.
*/

//there is error in coding here - fix it later - in the codes 
replace market_prob="1" if Q9_4=="Manque de clients"
replace market_prob="2" if Q9_4=="Augmentation des prix"
replace market_prob="3" if Q9_4=="Limitation des déplacements (barrages)"
replace market_prob="4" if Q9_4=="Insécurité (Vol, braquage)"
replace market_prob="5" if Q9_4=="Manque de moyens de transport"
replace market_prob="6" if Q9_4=="Fermeture des foires et marchés"
replace market_prob="7" if Q9_4=="Pas de difficulté / Contrainte"

label define marketprob_lab2 1 "Manque de clients" 2 "Augmentation des prix" ///
3 "Limitation des déplacements (barrages)" 4 "Insécurité (vol, braquage)" 5 "Manque de moyens de transports" ///
6 "Fermeture des foires et marchés" 7 "Pas de difficulté / Contrainte"  

destring market_prob, replace 
label values market_prob marketprob_lab2

codebook market_prob, tab(100)

save, replace 


asdoc tab market_prob 
asdoc tab region market_prob, row
asdoc tab residence market_prob, row

tab market_prob 
tab region market_prob, row
tab residence market_prob, row


tab Q12_2

generate security_mali="."
replace security_mali="1" if Q12_2=="Je ne sais pas"
replace security_mali="2" if Q12_2=="N?a pas changé"
replace security_mali="3" if Q12_2=="S?est améliorée"
replace security_mali="4" if Q12_2=="S?est détériorée"


label define sec_malilab 1 "Je ne sais pas" 2 "N’a pas changé" 3 "S’est améliorée" 4 "S’est détériorée"
destring security_mali, replace 
label values security_mali sec_malilab

codebook security_mali

asdoc tab security_mali
asdoc tab region security_mali, row


tab Q12_3

generate security_local="."

replace security_local="1" if Q12_3=="N?a pas changé"
replace security_local="2" if Q12_3=="S?est améliorée"
replace security_local="3" if Q12_3=="S?est détériorée"

tab security_local 

destring security_local, replace 


label define sec_loclab 1 "N’a pas changé" 2 "S’est améliorée" 3 "S’est détériorée"

label values security_local sec_loclab

codebook security_local

asdoc tab security_local
asdoc tab region security_local, row


save, replace

tab cercle security_local, row 


tab Q12_9_1 
tab Q12_9_2 
tab Q12_9_3 
tab Q12_9_4 
tab Q12_9_5 
tab Q12_9_6

generate adapt_autodefence=Q12_9_1 
generate adapt_armes=Q12_9_2 
generate adapt_limitdep=Q12_9_3 
generate adapt_moddep=Q12_9_4
generate adapt_habitudes=Q12_9_5
generate adapt_nourepart=Q12_9_6


foreach var of varlist adapt_autodefence-adapt_nourepart {
replace `var'="1" if `var'=="Oui"
replace `var'="0" if `var'=="Non"
}

foreach var of varlist adapt_autodefence-adapt_nourepart {
destring `var', replace
}

label define adapt_lab 0 "Non" 1 "Oui"

foreach var of varlist adapt_autodefence-adapt_nourepart {
label values `var' adapt_lab
}

save, replace 


foreach var of varlist adapt_autodefence-adapt_nourepart {
asdoc tab `var' 
}




