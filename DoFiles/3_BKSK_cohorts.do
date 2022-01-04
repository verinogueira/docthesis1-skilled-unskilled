/* Create schooling measures by country-year-cohorts */


/* Prepare variables from Barro-Lee dataset */
use "Input/BL2013_M_v2.2.dta", clear

keep if year==1960| year==1990

/* keep age-groups from 20-24 until 55-59 */
drop if agefrom<20
drop if ageto>60
drop if ageto==999


*** correct codes WB ***
drop WBcode country
sort BLcode year agefrom
merge m:m BLcode year using "Output/BarroLee_WB_codes6090.dta"

/* 
    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                             2,336  (_merge==3)
    -----------------------------------------

*/

drop _merge
 
 
gen a = (agefrom + ageto)/2 /* midpoint */
label variable a "age"

drop sex agefrom ageto
order BLcode WBcode country region_code year a 


/* population */
sort BLcode year a
bysort BLcode year : egen total_pop = total(pop)
label variable total_pop "L: working-age population"




/* calculate a perfected measure of years of schooling for incomplete secondary education */

*** merge with WB cleaned data ***
merge m:m WBcode year using "Output/WB_duration.dta"

/* 
    Result                           # of obs.
    -----------------------------------------
    not matched                           256
        from master                        48  (_merge==1)
        from using                        208  (_merge==2)

    matched                             2,288  (_merge==3)
    -----------------------------------------

Each country has 16 obs
3 countries not matched in from BL data: Sudan, Taiwan and Reunion	
Of those, only Taiwan has PWT data for 1960 and 1990
 */

drop if _merge < 3
drop _merge
*** 143 countries left ***


*** compute shares of educational attainament ***
 * secondary complete *
gen Lsc = lsc + lh
 * theoretical years of schooling percentage completed secondary *
gen YR_sch_sec = Duration * Lsc/100
 * theoretical years of schooling percentage NOT completed secondary *
gen YR_sch_sec_INC = yr_sch_sec - YR_sch_sec
	replace YR_sch_sec_INC=0 if YR_sch_sec_INC<0
	* (292 real changes made) out of 2,920 observations
sum Duration yr_sch_pri yr_sch_sec YR_sch_sec YR_sch_sec_INC

/*  
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
    Duration |      4,290    6.388112    .8809787          4          9
  yr_sch_pri |      4,290    3.225873    2.033233   .0071742   8.907681
  yr_sch_sec |      4,290    1.283774    1.321886   .0040947    7.69821
  YR_sch_sec |      4,290    1.086124    1.282357   .0019638   7.400073
YR_sch_sec~C |      4,290    .2737219    .3480877          0    2.80912
*/





***** construct years of schooling per cohort *****
* * * already weighted by population shares * * *
gen su_a = (yr_sch_pri + YR_sch_sec_INC)
gen ss_a = yr_sch

sum su_a ss_a


*****************************************************
   **** weithed average years of schooling ****
*****************************************************
gen SU_aw = (yr_sch_pri + YR_sch_sec_INC)*pop/total_pop
gen SS_aw = yr_sch*pop/total_pop
bysort BLcode year : egen su = total(SU_aw)
bysort BLcode year : egen ss = total(SS_aw)
label variable su "su: Unskilled years of schooling"
label variable ss "ss: Skilled years of schooling"
sum su ss 
	
		


/**** calculate "tau" less than completed secondary */
gen lss = ls - lsc /* some secondary minus completed secondary*/
gen lesssec = lu + lp + lss /* less than complete secondary */

gen moreandsec = lsc + lh /* completed secondary and more */
gen teste = lesssec + moreandsec
	sum teste /* should be all ~ 100 */
	drop moreandsec teste

gen lesssec2 = lesssec/100 
	drop lesssec
	rename lesssec2 lesssec
	label variable lesssec "share less than complete secondary"

gen lss2 = lss/100 
	drop lss
	rename lss2 lss
	label variable lss "share secondary incomplete"

sum lss lesssec
/* 

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
         lss |      4,290    .0872932    .0880858   2.59e-06    .657087
     lesssec |      4,290    .8340582    .1879128   .0532818   1.001005


*/

*** tau cannot be greater than 1 ***
replace lesssec=1 if lesssec > 1
/* (2 real changes made)*/ 



/* number of unskilled and skilled in population: L_U and L_S */
gen tauLa = pop*lesssec
bysort BLcode year : egen L_U = total(tauLa)
gen L_S = total_pop - L_U

sum L_S L_U
/* 

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
         L_S |      4,290    2143.768    8745.794   .4893036   100910.1
         L_U |      4,290    7879.982    32020.73   12.74852   374390.9

*/

/* share of unskilled and skilled in population, in percentage terms */
gen tau = L_U / total_pop *100
gen tauC = 100-tau

sum tau tauC
/* 

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
         tau |      4,290    81.18224    17.75986   20.93408   99.93616
        tauC |      4,290    18.81776    17.75986   .0638351   79.06592

*/



saveold "Output/BKSK_schooling.dta", replace /* Males 20-59 years old */


