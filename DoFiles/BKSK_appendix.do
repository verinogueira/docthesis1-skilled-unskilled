/* prepares the figures in the appendix */



use "Output/BKSK_wages_techn.dta", clear	

/* merging with bkenrol */
merge m:m BLcode using "Output/LeeLee_bkschool.dta"
*** not matched only from using (22) ***
*** 89 countries left ***
	keep if _merge==3	
	drop _merge

	sort WBcode year

	
	
********************
*** Figure 1.A.1 ***
********************


/* Unskilled human capital */
twoway (scatter hk_U bkschool, mlabel(WBcode)) (scatter hk_U bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0)) if year==1960, /// 
	yscale(range(0 4)) ylabel(0(1)4)   ///
		bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1960) legend(off) saving(temp1, replace) 
twoway (scatter hk_U bkschool, mlabel(WBcode)) (scatter hk_U bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0)) if year==1990, /// 
	yscale(range(0 4)) ylabel(0(1)4)   ///
	bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1990) legend(off) saving(temp2, replace)
graph combine temp1.gph temp2.gph, ///
 title("Unskilled human capital versus BK's schooling") ///
 plotregion(fcolor(white)) graphregion(fcolor(white)) ///
 commonscheme  scheme(sj) 
graph export "Exhibits/hU_enrol.png", as(png) replace


/* Skilled human capital */
twoway (scatter hk_S bkschool, mlabel(WBcode)) (scatter hk_S bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0)) if year==1960, /// 
	yscale(range(0 6)) ylabel(0(1.5)6)   ///
		bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1960) legend(off)  saving(temp1, replace) 
twoway (scatter hk_S bkschool, mlabel(WBcode)) (scatter hk_S bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0)) if year==1990, /// 
	yscale(range(0 6)) ylabel(0(1.5)6)   ///
	bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1990) legend(off)  saving(temp2, replace)
graph combine temp1.gph temp2.gph, ///
 title("Skilled human capital versus BK's schooling") ///
 plotregion(fcolor(white)) graphregion(fcolor(white)) ///
 commonscheme  scheme(sj) 
graph export "Exhibits/hS_enrol.png", as(png) replace


********************
*** Figure 1.A.2 ***
********************


/* BK* human capital */
twoway (scatter hk_bk bkschool, mlabel(WBcode)) (scatter hk_bk bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1960, /// 
	yscale(range(2 7)) ylabel(2(1)7)   ///
		bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1960) legend(off) saving(temp1, replace) 
twoway (scatter hk_bk bkschool, mlabel(WBcode)) (scatter hk_bk bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1990, /// 
	yscale(range(2 7)) ylabel(2(1)7)   ///
	bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1990) legend(off) saving(temp2, replace)
graph combine temp1.gph temp2.gph, ///
 title("BK*'s human capital versus BK's schooling") ///
 plotregion(fcolor(white)) graphregion(fcolor(white)) ///
 commonscheme  scheme(sj) 
graph export "Exhibits/HK_BK_enrol.png", as(png) replace

/* BJ human capital */
twoway (scatter hk_bj_14 bkschool, mlabel(WBcode)) (scatter hk_bj_14 bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1960, /// 
	yscale(range(0 30)) ylabel(0(5)30)   ///
		bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1960) legend(off) saving(temp1, replace) 
twoway (scatter hk_bj_14 bkschool, mlabel(WBcode)) (scatter hk_bj_14 bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1990, /// 
	yscale(range(0 30)) ylabel(0(5)30)   ///
	bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1990) legend(off) saving(temp2, replace)
graph combine temp1.gph temp2.gph, ///
 title("BJ's human capital versus BK's schooling") ///
 plotregion(fcolor(white)) graphregion(fcolor(white)) ///
 commonscheme  scheme(sj) 
graph export "Exhibits/HK_BJ_enrol.png", as(png) replace


/* BK* technology */
twoway (scatter A_bk bkschool, mlabel(WBcode)) (scatter A_bk bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1960, /// 
	yscale(range(0 15)) ylabel(0(5)15)   ///
		bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1960) legend(off) saving(temp1, replace) 
twoway (scatter A_bk bkschool, mlabel(WBcode)) (scatter A_bk bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1990, /// 
	yscale(range(0 15)) ylabel(0(5)15)   ///
	bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1990) legend(off) saving(temp2, replace)
graph combine temp1.gph temp2.gph, ///
 title("BK*'s technology versus BK's schooling") ///
 plotregion(fcolor(white)) graphregion(fcolor(white)) ///
 commonscheme  scheme(sj) 
graph export "Exhibits/A_BK_enrol.png", as(png) replace

/* BJ technology */
twoway (scatter A_bj bkschool, mlabel(WBcode)) (scatter A_bj bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1960, /// 
	yscale(range(0 3)) ylabel(0(1)3)   ///
		bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1960) legend(off) saving(temp1, replace) 
twoway (scatter A_bj bkschool, mlabel(WBcode)) (scatter A_bj bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1990, /// 
	yscale(range(0 3)) ylabel(0(1)3)   ///
	bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1990) legend(off) saving(temp2, replace)
graph combine temp1.gph temp2.gph, ///
 title("BJ's technology versus BK's schooling") ///
 plotregion(fcolor(white)) graphregion(fcolor(white)) ///
 commonscheme  scheme(sj) 
graph export "Exhibits/A_BJ_enrol.png", as(png) replace




********************
*** Figure 1.A.3 ***
********************

/* BK-A human capital */
twoway (scatter hk_bk_US bkschool, mlabel(WBcode)) (scatter hk_bk_US bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1960, /// 
	yscale(range(2 12)) ylabel(2(2)12)   ///
		bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1960) legend(off) saving(temp1, replace) 
twoway (scatter hk_bk_US bkschool, mlabel(WBcode)) (scatter hk_bk_US bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1990, /// 
	yscale(range(2 12)) ylabel(2(2)12)   ///
	bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1990) legend(off) saving(temp2, replace)
graph combine temp1.gph temp2.gph, ///
 title("BK-A's human capital versus BK's schooling") ///
 plotregion(fcolor(white)) graphregion(fcolor(white)) ///
 commonscheme  scheme(sj) 
graph export "Exhibits/HK_BKA_enrol.png", as(png) replace

/* BK-A technology */
twoway (scatter Au_bk bkschool, mlabel(WBcode)) (scatter Au_bk bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1960, /// 
	yscale(range(0 20)) ylabel(0(4)20)   ///
		bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1960) legend(off) saving(temp1, replace) 
twoway (scatter Au_bk bkschool, mlabel(WBcode)) (scatter Au_bk bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1990, /// 
	yscale(range(0 20)) ylabel(0(4)20)   ///
	bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1990) legend(off) saving(temp2, replace)
graph combine temp1.gph temp2.gph, ///
 title("BK-A's technology versus BK's schooling") ///
 plotregion(fcolor(white)) graphregion(fcolor(white)) ///
 commonscheme  scheme(sj) 
graph export "Exhibits/A_BKA_enrol.png", as(png) replace



/* CES human capital */
twoway (scatter h_A_14 bkschool, mlabel(WBcode)) (scatter h_A_14 bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1960, /// 
		bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1960) legend(off) saving(temp1, replace) 
twoway (scatter h_A_14 bkschool, mlabel(WBcode)) (scatter h_A_14 bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1990, /// 
	bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1990) legend(off) saving(temp2, replace)
graph combine temp1.gph temp2.gph, ///
 title("CES's human capital versus BK's schooling") ///
 plotregion(fcolor(white)) graphregion(fcolor(white)) ///
 commonscheme  scheme(sj) 
graph export "Exhibits/HK_CES_enrol.png", as(png) replace

/* CES technology */
twoway (scatter Au_A bkschool, mlabel(WBcode)) (scatter Au_A bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1960, /// 
	yscale(range(0 8)) ylabel(0(2)8)   ///
		bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1960) legend(off) saving(temp1, replace) 
twoway (scatter Au_A bkschool, mlabel(WBcode)) (scatter Au_A bkschool if WBcode =="USA", mcolor(gs0) msymbol(diamond) mlabel(WBcode) mlabcolor(gs0))  if year==1990, /// 
	yscale(range(0 8)) ylabel(0(2)8)   ///
	bgcolor(white) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
	title(1990) legend(off) saving(temp2, replace)
graph combine temp1.gph temp2.gph, ///
 title("CES's technology versus BK's schooling") ///
 plotregion(fcolor(white)) graphregion(fcolor(white)) ///
 commonscheme  scheme(sj) 
graph export "Exhibits/Au_CES_enrol.png", as(png) replace





*** GROWTH ***

use "Output/BKSK_dataset.dta", clear	


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



********************
*** Figure 1.A.4 ***
********************
twoway (scatter hk_bk_gr100 bkschool, mlabel(WBcode)) (lfit hk_bk_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Human Capital Growth (BK*)) scheme(sj) 
graph export "Exhibits/HK_growth_ghBK_MP.png", as(png) replace	

twoway (scatter hk_bj_14_gr100 bkschool, mlabel(WBcode)) (lfit hk_bj_14_gr100 bkschool, estopts(vce(robust)) lwidth(medthick) lpattern(solid)), ///
	title(Human Capital Growth (BJ)) scheme(sj) 
graph export "Exhibits/HK_growth_ghBJ_MP.png", as(png) replace	

twoway (scatter A_bk_gr100 bkschool, mlabel(WBcode)) (lfit A_bk_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Technology A Growth (BK*)) scheme(sj) 
graph export "Exhibits/HK_growth_gABK_MP.png", as(png) replace	

twoway (scatter A_bj_gr100 bkschool, mlabel(WBcode)) (lfit A_bj_gr100 bkschool, estopts(vce(robust)) lwidth(medthick) lpattern(solid)), ///
	title(Technology A Growth (BJ)) scheme(sj) 
graph export "Exhibits/HK_growth_gABJ_MP.png", as(png) replace	

twoway (scatter hk_U_gr100 bkschool, mlabel(WBcode)) (lfit hk_U_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Unskilled Human Capital Growth)  scheme(sj) 
graph export "Exhibits/HK_growth_hU.png", as(png) replace  

twoway (scatter hk_S_gr100 bkschool, mlabel(WBcode)) (lfit hk_S_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Skilled Human Capital Growth)  scheme(sj) 
graph export "Exhibits/HK_growth_hS.png", as(png) replace  



********************
*** Figure 1.A.5 ***
********************
twoway (scatter hk_bk_US_gr100 bkschool, mlabel(WBcode)) (lfit hk_bk_US_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	yscale(range(0 3)) ylabel(0(1)3) title(Human Capital Growth (BK-A))  scheme(sj) 
graph export "Exhibits/HK_growth_ghBKA_MP.png", as(png) replace	
 
twoway (scatter Au_bk_gr100 bkschool, mlabel(WBcode)) (lfit Au_bk_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Technology Au Growth (BK-A))  scheme(sj) 
graph export "Exhibits/HK_growth_gAuBK_MP.png", as(png) replace

twoway (scatter As_bk_gr100 bkschool, mlabel(WBcode)) (lfit As_bk_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Technology As Growth (BK-A))  scheme(sj) 
graph export "Exhibits/HK_growth_gAsBK_MP.png", as(png) replace

twoway (scatter SPhS_BKA_gr100 bkschool, mlabel(WBcode)) (lfit SPhS_BKA_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Skill Premium times Skilled Human Capital Growth)  scheme(sj) 
graph export "Exhibits/HK_growth_term2BKA.png", as(png) replace 




********************
*** Figure 1.A.6 ***
********************
twoway (scatter h_A_14_gr100 bkschool, mlabel(WBcode)) (lfit h_A_14_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	yscale(range(0 20)) ylabel(0(10)20) title(Human Capital Growth (CES))  scheme(sj) 
graph export "Exhibits/HK_growth_ghA_MP.png", as(png) replace	

twoway (scatter Au_A_gr100 bkschool, mlabel(WBcode)) (lfit Au_A_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Technology Au Growth (CES))  scheme(sj) 
graph export "Exhibits/HK_growth_gAuA_MP.png", as(png) replace	

twoway (scatter As_A_gr100 bkschool, mlabel(WBcode)) (lfit As_A_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Technology As Growth (CES))  scheme(sj) 
graph export "Exhibits/HK_growth_gAsA_MP.png", as(png) replace	

twoway (scatter rel_AsAu_gr100 bkschool, mlabel(WBcode)) (lfit rel_AsAu_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Skill Bias Growth (CES))  scheme(sj) 
graph export "Exhibits/HK_growth_skillbias.png", as(png) replace

twoway (scatter SBhS_CES_gr100 bkschool, mlabel(WBcode)) (lfit SBhS_CES_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Skill Bias times Skilled Human Capital Growth (CES))  scheme(sj) 
graph export "Exhibits/HK_growth_term2CES.png", as(png) replace

twoway (scatter rel_hShU_gr100 bkschool, mlabel(WBcode)) (lfit rel_hShU_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Relative Skill Supplies Growth)  scheme(sj) 
graph export "Exhibits/HK_growth_skillsupply.png", as(png) replace


twoway (scatter spr_mp_gr100 bkschool, mlabel(WBcode)) (lfit spr_mp_gr100 bkschool, estopts(vce(robust)) lwidth(medium) lpattern(solid)), ///
	title(Skill Premium Growth)  scheme(sj) 
graph export "Exhibits/HK_growth_skillpremium.png", as(png) replace  
