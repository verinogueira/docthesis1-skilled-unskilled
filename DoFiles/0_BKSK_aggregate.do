**** This files uses PWT, Barro-Lee and Lee-Lee to produce the following ****
**** variables for years 1960 and 1990 ***
	** country codes	**
	** bkschool			**
	** output 			**
	** capital 			**
	

/* Barro-Lee data */ 

*** country codes ***
use "Input/BL2013_M_v2.2.dta", clear
keep if year==1960 | year==1990
keep BLcode country WBcode year 
sort BLcode year
saveold "Output/BarroLee_WB_codes6090.dta", replace


/* Lee-Lee data */ 

**** enrollment ***
use "Input/LeeLee_v1.dta", clear
keep if year==1960
keep if sex=="M"
keep if agefrom==15 & ageto==64
gen bkschool = 6*pri/100 + 6*sec/100 + 5*ter/100
keep BLcode country bkschool
sort BLcode
saveold "Output/LeeLee_bkschool.dta", replace




/* Penn World Tables */

use "Input\PWT90.dta", clear
	keep countrycode country year rgdpna rkna
	keep if year==1960 | year==1990
	rename countrycode WBcode
	sort WBcode year
	
merge m:m WBcode year using "Output/BarroLee_WB_codes6090.dta"

/* 
 
    Result                           # of obs.
    -----------------------------------------
    not matched                           360
        from master                        90  (_merge==1)
        from using                        270  (_merge==2)

    matched                             4,110  (_merge==3)
    -----------------------------------------

*/

	drop if _merge<3
	drop _merge
	collapse (firstnm) WBcode country rgdpna rkna, by(BLcode year) 
	*** 137 countries left ***
	sort BLcode year
	order BLcode WBcode year country


saveold "Output/BKSK_aggregate.dta", replace

