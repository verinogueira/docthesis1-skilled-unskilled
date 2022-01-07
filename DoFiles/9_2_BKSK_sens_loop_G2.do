/* RUN BY "BKSK_sensitivity.do" - DO FILE TO LOOP IN SENSITIVITY */

foreach s of numlist 2 4 6 8 9 11 12 13 14 15 16 17 18 19 20 25 30 35 40 50 60 70 80 90 100 200 300 400 500 600 700 800 1000 2000 10000 100000 1000000 10000000 100000000 1000000000 {

use "Output/BKSK_sensitivity.dta", clear
	gen sigma = `s'/10

	
*** Tested Equation: (CES) ***

/* calculate ratio of technology terms */
gen lnrel_AsAu = (sigma*lnspr_mp+lnrel_hShU)/(sigma - 1)
label variable lnrel_AsAu "Log of Relative Technology Terms As/Au (CES)"
gen rel_AsAu = exp(lnrel_AsAu)
label variable rel_AsAu "Relative Technology Terms As/Au (CES)"

/* * * pinn down Au * * */
gen Au_A = gdpWAP^(1/(1-alpha)) * rknaWAP^(-alpha/(1-alpha)) * (hk_U^((sigma-1)/sigma) + (rel_AsAu*hk_S)^((sigma-1)/sigma))^(-sigma/(sigma-1)) 

/* * * pinn down As * * */
gen As_A = rel_AsAu*Au_A
  
/* calculate aggregate HK */
gen h_A_14 = ((hk_U^((sigma -1)/sigma)) + ((rel_AsAu*hk_S)^((sigma -1)/sigma)))^(sigma/(sigma - 1))
label variable h_A_14 "h: aggregation (CES)"
**********************************************************************************************************

***  HK growth ***
sort BLcode year

* (CES) *
by BLcode: gen h_A_14_gr30 = h_A_14 / h_A_14[_n-1]
by BLcode: gen h_A_14_gr = (h_A_14_gr30^(1/30))-1
gen h_A_14_gr100 = h_A_14_gr*100
label variable h_A_14_gr100 "gh (CES)"
drop h_A_14_gr30 h_A_14_gr 

drop if missing(h_A_14_gr100)


/* import enrolment BK */
*** merging with bkenrol ***
merge m:m BLcode using "Output/LeeLee_bkschool.dta"
	keep if _merge==3	
	drop _merge
label variable bkschool "BK's enrolment (1960)"



/* REGRESSIONS in loop over sigma */

tempfile temp_`s'
parmby "regress h_A_14_gr100 bkschool, vce(robust)", lab saving(`"temp_`s'"', replace) idn(1) ids(Unadjusted)
	drop _all
use temp_`s'.dta, clear 
	gen sigma = `s'/10
saveold temp_`s'.dta, replace 
	drop _all
}
*
