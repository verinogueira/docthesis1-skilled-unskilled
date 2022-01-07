/* RUN BY "BKSK_sensitivity.do" - DO FILE TO LOOP IN SENSITIVITY */

foreach s of numlist 2 4 6 8 9 11 12 13 14 15 16 17 18 19 20 25 30 35 40 50 60 70 80 90 100 200 300 400 500 600 700 800 1000 2000 10000 100000 1000000 10000000 100000000 1000000000 {

use "Output/BKSK_sensitivity.dta", clear
	gen sigma = `s'/10
	
		
*** Tested Equation: (BJ) ***
gen hk_bj_14 = ((hk_U^((sigma -1)/sigma)) + (hk_S^((sigma -1)/sigma)))^(sigma/(sigma - 1))
label variable hk_bj_14 "BJ's clone"


/* * * * GROWTH * * * */
sort BLcode year

by BLcode: gen hk_bj_14_gr30 = hk_bj_14 / hk_bj_14[_n-1]
by BLcode: gen hk_bj_14_gr = (hk_bj_14_gr30^(1/30))-1
gen hk_bj_14_gr100 = hk_bj_14_gr*100
label variable hk_bj_14_gr100 "gh BJ"
drop hk_bj_14_gr30 hk_bj_14_gr 

drop if missing(hk_bj_14_gr100)


/* import enrolment BK */
*** merging with bkenrol ***
merge m:m BLcode using "Output/LeeLee_bkschool.dta"
	keep if _merge==3	
	drop _merge
label variable bkschool "BK's enrolment (1960)"



/* REGRESSIONS in loop over sigma */
	
tempfile temp_`s'
parmby "regress hk_bj_14_gr100 bkschool, vce(robust)", lab saving(`"temp_`s'"', replace) idn(1) ids(Unadjusted)
	drop _all
use temp_`s'.dta, clear 
	gen sigma = `s'/10
saveold temp_`s'.dta, replace 
	drop _all
}
*
