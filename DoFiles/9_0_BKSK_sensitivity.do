/* performs the sensitivity test */


/* prepare clean file */
use "Output/BKSK_wages_techn.dta", clear	
	keep BLcode WBcode year hk_U hk_S gdpWAP rknaWAP lnspr_mp lnrel_hShU alpha

saveold "Output/BKSK_sensitivity.dta", replace	

*** reduce to the sample of 74 countries ***
use "Output/BKSK_sensitivity.dta", clear	
	merge m:m BLcode using "Output/BKSK_countries.dta"
	keep if _merge==3	
	drop _merge
	sort BLcode year
saveold "Output/BKSK_sensitivity.dta", replace




***********************************************************************************************
                      /*** GROUP 1 ***/
***********************************************************************************************

*** loop on different values of sigma ***
run "DoFiles/9_1_BKSK_sens_loop_G1.do"

*** combine into a dataset ***
use "temp_2.dta", clear 
	foreach s of numlist 2 4 6 8 9 11 12 13 14 15 16 17 18 19 20 25 30 35 40 50 60 70 80 90 100 200 300 400 500 600 700 800 1000 2000 10000 100000 1000000 10000000 100000000 1000000000 {
		append using "temp_`s'" 
	}
	*
saveold "Output/BKSK_sensitivity_BJ.dta", replace	
 
*** delete temp files ***
foreach s of numlist 2 4 6 8 9 11 12 13 14 15 16 17 18 19 20 25 30 35 40 50 60 70 80 90 100 200 300 400 500 600 700 800 1000 2000 10000 100000 1000000 10000000 100000000 1000000000 {
	erase "temp_`s'.dta" 
}
*

*** Figure 1.4 (a) ***
use "Output/BKSK_sensitivity_BJ.dta", clear 

*** input yline = slope of BK*=0.0353 ***
twoway (rarea min95 max95 sigma if parmseq ==2 & sigma<5 & sigma>1.2, fcolor(gray) fintensity(10) lpattern(dash)) ///
	(connected estimate sigma if parmseq ==2 & sigma<5 & sigma>1.2, mcolor(gray) lcolor(gray)) ///
	(rarea min95 max95 sigma if parmseq ==1 & sigma<5 & sigma>1.2, yaxis(2) fcolor(gray) fintensity(10) lpattern(dash)) ///
	(connected estimate sigma if parmseq ==1 & sigma<5 & sigma>1.2, yaxis(2) mcolor(black) lcolor(black)), ///	
	xline(1.4, lwidth(medthick)) xscale(range(1 4)) xlabel(1(0.5)4) yline(0.0353, axis(2) lwidth(medthick)) ///
	legend(order(1 "95%  Confidence interval" 2 "Constant" 3 "95%  Confidence interval" 4 "Slope")) ///
	scheme(sj) ytitle(Constant) ytitle(Slope, axis(2)) 
graph export "Exhibits/BKCES_sensitivity_BJ2.png", as(png) replace



***********************************************************************************************
                      /*** GROUP 2 ***/
***********************************************************************************************

*** loop on different values of sigma ***
run "DoFiles/9_2_BKSK_sens_loop_G2.do"

*** combine into a dataset ***
use "temp_2.dta", clear 
	foreach s of numlist 2 4 6 8 9 11 12 13 14 15 16 17 18 19 20 25 30 35 40 50 60 70 80 90 100 200 300 400 500 600 700 800 1000 2000 10000 100000 1000000 10000000 100000000 1000000000 {
		append using "temp_`s'" 
	}
	*
saveold "Output/BKSK_sensitivity_CES.dta", replace	
 
*** delete temp files ***
foreach s of numlist 2 4 6 8 9 11 12 13 14 15 16 17 18 19 20 25 30 35 40 50 60 70 80 90 100 200 300 400 500 600 700 800 1000 2000 10000 100000 1000000 10000000 100000000 1000000000 {
	erase "temp_`s'.dta" 
}
*

*** Figure 1.4 (b) ***
use "Output/BKSK_sensitivity_CES.dta", clear	

*** input yline = slope of BK-A=0.115 ***
twoway (rarea min95 max95 sigma if parmseq ==2 & sigma<5 & sigma>1.2, fcolor(gray) fintensity(10) lpattern(dash)) ///
	(connected estimate sigma if parmseq ==2 & sigma<5 & sigma>1.2, mcolor(gray) lcolor(gray)) ///
	(rarea min95 max95 sigma if parmseq ==1 & sigma<5 & sigma>1.2, yaxis(2) fcolor(gray) fintensity(10) lpattern(dash)) ///
	(connected estimate sigma if parmseq ==1 & sigma<5 & sigma>1.2, yaxis(2) mcolor(black) lcolor(black)), ///	
	xline(1.4, lwidth(medthick)) xscale(range(1 4)) xlabel(1(0.5)4) yline(0.115, axis(2) lwidth(medthick)) ///
	legend(order(1 "95%  Confidence interval" 2 "Constant" 3 "95%  Confidence interval" 4 "Slope")) ///
	scheme(sj) ytitle(Constant) ytitle(Slope, axis(2)) 
graph export "Exhibits/BKCES_sensitivity_CES2.png", as(png) replace
