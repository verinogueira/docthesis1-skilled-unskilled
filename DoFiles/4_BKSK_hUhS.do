/* calculate the subaggregate measures hU and hS */
/* also aggregate human capital using BK and BJ */



/* Prepare variables from Barro-Lee dataset */
use "Output/BKSK_schooling.dta", clear

*** obs: variable total_pop is "L: working-age population" ***
**** L = L_U + L_S ****


/**** calculate the cohorts' HK [Equation 1.2] ***/
*** average mincer coefficients from BK's paper ***

***** BK OLD - used only for comparison in Table 1.1 *****
gen lnhk_bk_a = 0.0956346153846154* yr_sch + 0.0512307692307692*(a - yr_sch - 6) + -0.000706923076923077*(a - yr_sch - 6)^2
gen hk_bk_a = exp(lnhk_bk_a) 
label variable hk_bk_a "BK's cohort human capital"
sum lnhk_bk_a hk_bk_a
	  
/*  
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
   lnhk_bk_a |      2,288    1.278856     .292492   .6396059   2.131965
     hk_bk_a |      2,288    3.754709    1.165715   1.895734   8.431416
 */
	 
gen hk_bk_w = hk_bk_a*pop/total_pop /* weighted cohort hk */
	 
	 
**** measures of unskilled and skilled human capital used everywhere else ***
*** cohorts' HK with respective years of schooling ***
gen lnhk_U_a = 0.0956346153846154* su_a + 0.0512307692307692*(a - su_a - 6) + -0.000706923076923077*(a - su_a - 6)^2
gen lnhk_S_a = 0.0956346153846154* ss_a + 0.0512307692307692*(a - ss_a - 6) + -0.000706923076923077*(a - ss_a - 6)^2
gen hk_U_a = exp(lnhk_U_a) 
gen hk_S_a = exp(lnhk_S_a) 
label variable hk_U_a "Unskilled cohort human capital"
label variable hk_S_a "Skilled cohort human capital"
sum hk_U_a hk_S_a hk_bk_a 
/* hk_bk_a identical to hk_S_a , as expected

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      hk_U_a |      2,288    3.272701    .7157167   1.895081    5.72392
      hk_S_a |      2,288    3.754709    1.165715   1.895734   8.431416
     hk_bk_a |      2,288    3.754709    1.165715   1.895734   8.431416
*/
***********************************************************************

saveold "Output/BKSK_cohorts.dta", replace	




use "Output/BKSK_cohorts.dta", clear	


/**** calculate the subaggregate HK of U and S workers ****/
gen hk_w_U = hk_U_a*pop*lesssec/total_pop
gen hk_w_S = hk_S_a*pop*(1-lesssec)/total_pop
bysort BLcode year : egen hk_U = total(hk_w_U)
bysort BLcode year : egen hk_S = total(hk_w_S)
label variable hk_U "h_U: Unskilled human capital"
label variable hk_S "h_S: Skilled human capital"
sum hk_U hk_S 
/* 
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
        hk_U |      2,288     2.43331    .5552851   .5574245   3.887581
        hk_S |      2,288    .9953771    1.157901   .0014459    5.52139
 */



/*** calculate the aggregate HK ***/
*** BK ***
bysort BLcode year : egen hk_bkX = total(hk_bk_w)
label variable hk_bkX "BK's clone - original"

gen hk_bk = hk_U + hk_S
label variable hk_bk "BK's clone"

sum hk_bk hk_bkX
/* 
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
       hk_bk |      2,288    3.428687    .8297655   2.253345   6.086617
      hk_bkX |      2,288    3.693555    .9987157   2.254382   6.492003
*/

*****************************************************

gen sigma = 1.4

*** Ben Jones (2014) ***
gen hk_bj_14 = ((hk_U^((sigma -1)/sigma)) + (hk_S^((sigma -1)/sigma)))^(sigma/(sigma - 1))
label variable hk_bj_14 "BJ's clone"
*****************************************************

saveold "Output/BKSK_cohorts.dta", replace	





/* aggregating by country-year */
 
collapse (firstnm) WBcode country total_pop su ss L_U L_S tau tauC hk_U hk_S hk_bkX hk_bk sigma hk_bj_14, by(BLcode year)  
order BLcode WBcode country year

label variable WBcode WBcode
label variable country country
label variable sigma sigma
label variable tau "Share of unskilled ({1-&tau})"
label variable tauC "Share of skilled ({&tau})"
label variable L_U "L_U: population unskilled"
label variable L_S "L_S: population skilled"

label variable total_pop "L: working-age population 20-59"
label variable hk_U "h_U: Unskilled human capital"
label variable hk_S "h_S: Skilled human capital"
label variable su "su: Unskilled years of schooling"
label variable ss "ss: Skilled years of schooling"
label variable hk_bk "BK* (hu+hs)"
label variable hk_bkX "BK's clone"
label variable hk_bj_14 "BJ's clone"


saveold "Output/BKSK_humancapital.dta", replace	
