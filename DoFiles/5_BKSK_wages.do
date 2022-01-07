/* calculate the wages and skill premium */


/* years of schooling for male working age pop (15-64 yo) */
use "Input/BL2013_M_v2.2.dta", clear

*** generate pop 15-64 ***
keep if year==1960| year==1990
drop if ageto>64 /* keep age-groups 15-64 */

sort BLcode year agefrom
bysort BLcode year : egen total_pop1564 = total(pop)
label variable total_pop1564 "WAP 15-64yo"

**** warning: this alternative measure is just used in the calculation of wages ***


*** add data duration SECONDARY EDUCATION ***
sort WBcode year agefrom
merge m:m WBcode year using "Output/WB_duration.dta"
/* 
    Result                           # of obs.
    -----------------------------------------
    not matched                           268
        from master                        60  (_merge==1)
        from using                        208  (_merge==2)

    matched                             2,860  (_merge==3)
    -----------------------------------------
*/

drop if _merge<3
drop _merge
 
sort WBcode year agefrom


 * share secondary complete = complete secondary + some tertiary *
gen Lsc = lsc + lh
 * theoretical years of schooling percentage completed = duration secondary * proportion complete secondary*
gen YR_sch_sec = Duration * Lsc/100
 * theoretic years of schooling percentage NOT completed *
gen YR_sch_sec_INC = yr_sch_sec - YR_sch_sec
replace YR_sch_sec_INC=0 if YR_sch_sec_INC<0
* (293 real changes made) out of 2,336 observations
sum Duration yr_sch_sec YR_sch_sec YR_sch_sec_INC

/*
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
    Duration |      2,860    6.388112    .8810301          4          9
  yr_sch_sec |      2,860    1.502522    1.446787   .0014311    7.69821
  YR_sch_sec |      2,860    1.231009    1.410916   .0009339   7.400073
YR_sch_sec~C |      2,860    .3579619    .4536991          0   3.641933

 */



***** construct years of schooling *****
gen su_ap = (yr_sch_pri + YR_sch_sec_INC)*pop/total_pop1564
gen ss_ap = yr_sch*pop/total_pop1564


sort BLcode year agefrom
bysort BLcode year : egen su_1564 = total(su_ap)
bysort BLcode year : egen ss_1564 = total(ss_ap)
label variable su_1564 "Years of Schooling - Unskilled"
label variable ss_1564 "Years of Schooling - Skilled"
sum su_1564 ss_1564


/* obs: some countries have high duration for primary *

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
     su_1564 |      2,860    4.156324    1.978796   .0525933   8.690316
     ss_1564 |      2,860    5.593773    3.004882   .0577308   12.50858

*/

*** country-year dataset ***
collapse (firstnm) WBcode country total_pop1564 su_1564 ss_1564, by(BLcode year) 
order BLcode WBcode year
sort BLcode year

saveold "Output/BKSK_wages.dta", replace	






*** import country-specific Mincerian coefficients ***
use "Output/BKSK_wages.dta", clear

sort BLcode year 
	merge m:m BLcode year using "Output/BKSK_mincer.dta" 
/* 

    Result                           # of obs.
    -----------------------------------------
    not matched                            33
        from master                        33  (_merge==1)
        from using                          0  (_merge==2)

    matched                               220  (_merge==3)
    -----------------------------------------
*/


    drop if _merge<3
	drop _merge

	sort BLcode year 

saveold "Output/BKSK_wages.dta", replace	
	
	
/* calculate wages */
gen ln_wu_mp_1564 = MP_theta*su_1564
gen ln_ws_mp_1564 = MP_theta*ss_1564

gen wu_mp_1564 = exp(ln_wu_mp_1564) 
gen ws_mp_1564 = exp(ln_ws_mp_1564) 
label variable wu_mp_1564 "Wages unskilled"
label variable ws_mp_1564 "Wages skilled"
 
* * * skill premium * * * 
gen spr_mp = ws_mp_1564/wu_mp_1564
label variable spr_mp "Skill Premium"
gen lnspr_mp = ln(spr_mp)
label variable lnspr_mp "Log of Skill Premium"


saveold "Output/BKSK_wages.dta", replace	

