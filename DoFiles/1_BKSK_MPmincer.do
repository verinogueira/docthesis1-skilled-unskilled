/* import country-specific Mincerian coefficients */
*** from Montenegro and Patrinos ***


/* importing and cleaning */
import excel "Input\MP_mincer.xls", sheet("text to columns space") firstrow clear
	drop sample constant
	rename year MP_year
	gen WBcode = substr(ccode,1,3) 
	drop ccode 
	rename exp MP_gamma
	rename exp2 MP_gamma2
	rename educy MP_theta
	drop if missing(WBcode)
	destring MP_year MP_gamma MP_gamma2 MP_theta, replace
saveold "Output/MP_mincer.dta", replace	



use "Output/MP_mincer.dta", clear	

/* picking oldest year */	
sort WBcode MP_year
collapse (firstnm) MP_theta, by(WBcode) 
 

*** correct codes WB ***
merge m:m WBcode using "Output/BarroLee_WB_codes6090.dta"
/*

    Result                           # of obs.
    -----------------------------------------
    not matched                            99
        from master                        27  (_merge==1)
        from using                         72  (_merge==2)

    matched                               220  (_merge==3)
    -----------------------------------------
*/	
	
    drop if _merge<3
	drop _merge

collapse (firstnm) WBcode MP_theta, by(BLcode year) 
	sort BLcode year 
	order BLcode WBcode year MP_theta
	
saveold "Output/BKSK_mincer.dta", replace	
