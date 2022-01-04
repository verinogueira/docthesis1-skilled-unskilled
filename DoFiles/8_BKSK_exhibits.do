/* prepares the figures and tables of the main body */

use "Output/BKSK_dataset.dta", clear	



/* TABLE 1.1: descriptive stats */


*** relabelling ***
label variable gdpWAP_gr100 "GDP per worker growth gy (%)"
label variable rknaWAP_gr100 "Capital per worker growth gk (%)"
label variable ghgA "Technology + human capital g_A+g_h (%)"

label variable bkschool "BK's Schooling 1960 (years)"
label variable d_tauC "Change in share of skilled (p.p.)"
label variable d_su "Change in y.o.s. of unskilled (years)"
label variable d_ss "Change in y.o.s. of skilled (years)"

label variable hk_U_gr100 "Unskilled human capital growth"
label variable hk_S_gr100 "Skilled human capital growth"
label variable rel_hShU_gr100 "Relative supplies growth"
label variable spr_mp_gr100 "Skill premium growth (%)"

label variable hk_bkX_gr100 "BK human capital growth g_h (%)"
label variable hk_bk_gr100 "BK* human capital growth g_h (%)"
label variable hk_bj_14_gr100 "BJ human capital growth g_h (%)"
label variable A_bkX_gr100 "BK technology growth g_A (%)"
label variable A_bk_gr100 "BK* technology growth g_A (%)"
label variable A_bj_gr100 "BJ technology growth g_A (%)"

label variable hk_bk_US_gr100 "BK-A human capital growth g_h (%)"
label variable h_A_14_gr100 "CES human capital growth g_h (%)"
label variable Au_bk_gr100 "BK-A unskilled tech. growth g_{A_U} (%)"
label variable Au_A_gr100 "CES unskilled tech. growth g_{A_U} (%)"
label variable As_bk_gr100 "BK-A skilled tech. growth g_{A_S} (%)"
label variable As_A_gr100 "CES skilled tech. growth g_{A_S} (%)"
label variable rel_AsAu_gr100 "CES skill bias growth (%)"



*** Latex table ***
*ssc install sutex, replace
sutex gdpWAP_gr100 rknaWAP_gr100 ghgA bkschool d_tauC d_su d_ss hk_U_gr100 hk_S_gr100 rel_hShU_gr100 spr_mp_gr100 hk_bkX_gr100 hk_bk_gr100 hk_bj_14_gr100 A_bkX_gr100 A_bk_gr100 A_bj_gr100 hk_bk_US_gr100 h_A_14_gr100 Au_bk_gr100 Au_A_gr100 As_bk_gr100 As_A_gr100 rel_AsAu_gr100, lab nobs key(descstat) /// 
replace file("Exhibits/Tab1_descriptive.tex") title("Descriptive statistics") minmax
******************************************************



/* REGRESSIONS */



*** relabelling ***
label variable gdpWAP_gr100 "GDP per worker growth gy"
label variable rknaWAP_gr100 "Capital per worker growth gk"
label variable ghgA "Technology + human capital gA+gh"

label variable bkschool "BK's Schooling 1960 (years)"
label variable d_tauC "Change in share of skilled (p.p.)"
label variable d_su "Change in y.o.s. of unskilled (years)"
label variable d_ss "Change in y.o.s. of skilled (years)"

label variable hk_U_gr100 "Unskilled human capital growth"
label variable hk_S_gr100 "Skilled human capital growth"
label variable rel_hShU_gr100 "Relative supplies growth"
label variable spr_mp_gr100 "Skill premium growth"

label variable hk_bkX_gr100 "BK human capital growth gh"
label variable hk_bk_gr100 "BK* human capital growth gh"
label variable hk_bj_14_gr100 "BJ human capital growth gh"
label variable A_bkX_gr100 "BK technology growth gA"
label variable A_bk_gr100 "BK* technology growth gA"
label variable A_bj_gr100 "BJ technology growth gA"

label variable hk_bk_US_gr100 "BK-A human capital growth gh"
label variable h_A_14_gr100 "CES human capital growth gh"
label variable Au_bk_gr100 "BK-A unskilled tech. growth g{A_U}"
label variable Au_A_gr100 "CES unskilled tech. growth g{A_U}"
label variable As_bk_gr100 "BK-A skilled tech. growth g{A_S}"
label variable As_A_gr100 "CES skilled tech. growth g{A_S}"
label variable rel_AsAu_gr100 "CES skill bias growth"


*ssc install estout, replace

*** Table 1.2 ***
eststo clear
eststo: regress ghgA bkschool, vce(robust)
eststo: regress hk_bk_gr100 bkschool, vce(robust)
eststo: regress A_bk_gr100 bkschool, vce(robust)
eststo: regress hk_bj_14_gr100 bkschool, vce(robust)
eststo: regress A_bj_gr100 bkschool, vce(robust)
esttab using "Exhibits/Tab12_BKBJ.tex", se ar2 replace booktabs         ///
     title(Human Capital and Technology Growth on Enrolment (BK*,BJ))   
eststo clear

  
*** Table 1.3 ***
eststo clear
eststo: regress hk_bk_US_gr100 bkschool, vce(robust)
eststo: regress Au_bk_gr100 bkschool, vce(robust)
eststo: regress h_A_14_gr100 bkschool, vce(robust)
eststo: regress Au_A_gr100 bkschool, vce(robust)
esttab using "Exhibits/Tab13_BKACES.tex", se ar2 replace booktabs         ///
     title(Human Capital and Technology Growth on Enrolment (BK-A, CES))    
eststo clear

  



/* PLOTS */


*** Figure 1.1 ***
twoway (scatter Au_bk_gr100 d_tauC, mcolor(gs7) msymbol(circle) mlabel(WBcode) mlabcolor(gs7)) ///
	(scatter As_bk_gr100 d_tauC, mcolor(black) msymbol(triangle) mlabel(WBcode) mlabcolor(black)), ///
	 legend(rows(1)) scheme(sj) 	  
graph export "Exhibits/growth_tau_AuAs_BK.png", as(png) replace	 

twoway (scatter Au_A_gr100 d_tauC, mcolor(gs7) msymbol(circle) mlabel(WBcode) mlabcolor(gs7)) ///
	(scatter As_A_gr100 d_tauC, mcolor(black) msymbol(triangle) mlabel(WBcode) mlabcolor(black)), ///
	 legend(rows(1)) scheme(sj) 
graph export "Exhibits/growth_tau_AuAs_A.png", as(png) replace	 



*** Figure 1.2 ***
twoway (scatter hk_bk_gr100 bkschool, mlabel(WBcode)) (lfit hk_bk_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Human Capital Growth (BK*)) scheme(sj) 	
graph export "Exhibits/HK_growth_ghBK_MP.png", as(png) replace	

twoway (scatter hk_bj_14_gr100 bkschool, mlabel(WBcode)) (lfit hk_bj_14_gr100 bkschool, estopts(vce(robust)) lwidth(medthick) lpattern(solid)), ///
	title(Human Capital Growth (BJ)) scheme(sj) 
graph export "Exhibits/HK_growth_ghBJ_MP.png", as(png) replace	


*** Figure 1.3 ***

twoway (scatter hk_bk_US_gr100 bkschool, mlabel(WBcode)) (lfit hk_bk_US_gr100 bkschool, estopts(vce(robust))), ///
	title(Human Capital Growth (BK-A)) scheme(sj)
graph export "Exhibits/HK_growth_ghBKA_MP.png", as(png) replace	


twoway (scatter hk_bk_US_gr100 bkschool, mlabel(WBcode)) (lfit hk_bk_US_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	yscale(range(0 3)) ylabel(0(1)3) title(Human Capital Growth (BK-A))  scheme(sj) 
graph export "Exhibits/HK_growth_ghA_MP.png", as(png) replace	

