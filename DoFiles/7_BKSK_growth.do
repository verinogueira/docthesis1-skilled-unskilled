/* prepares the final dataset with the growth of the variables */


use "Output/BKSK_wages_techn.dta", clear	


/* * * * GROWTH * * * */

/********  gh + gA  *********/
sort BLcode year

by BLcode: gen gdpWAP_gr30 = gdpWAP / gdpWAP[_n-1]
by BLcode: gen gdpWAP_gr = (gdpWAP_gr30^(1/30))-1
gen gdpWAP_gr100 = gdpWAP_gr*100
label variable gdpWAP_gr100 "GDP per WAP average annual growth"
drop gdpWAP_gr30 gdpWAP_gr 

by BLcode: gen rknaWAP_gr30 = rknaWAP / rknaWAP[_n-1]
by BLcode: gen rknaWAP_gr = (rknaWAP_gr30^(1/30))-1
gen rknaWAP_gr100 = rknaWAP_gr*100
label variable rknaWAP_gr100 "Capital per WAP average annual growth"
drop rknaWAP_gr30 rknaWAP_gr 

gen ghgA = (3/2)*(gdpWAP_gr100-(1/3)*rknaWAP_gr100)
label variable ghgA "gA+gh"


/********  ghU e ghS  *********/
sort BLcode year

by BLcode: gen hk_U_gr30 = hk_U / hk_U[_n-1]
by BLcode: gen hk_U_gr = (hk_U_gr30^(1/30))-1
gen hk_U_gr100 = hk_U_gr*100
label variable hk_U_gr100 "ghU"
drop hk_U_gr30 hk_U_gr 

by BLcode: gen hk_S_gr30 = hk_S / hk_S[_n-1]
by BLcode: gen hk_S_gr = (hk_S_gr30^(1/30))-1
gen hk_S_gr100 = hk_S_gr*100
label variable hk_S_gr100 "ghS"
drop hk_S_gr30 hk_S_gr 

by BLcode: gen rel_hShU_gr30 = rel_hShU / rel_hShU[_n-1]
by BLcode: gen rel_hShU_gr = (rel_hShU_gr30^(1/30))-1
gen rel_hShU_gr100 = rel_hShU_gr*100
label variable rel_hShU_gr100 "g(hS/hU)"
drop rel_hShU_gr30 rel_hShU_gr 

sum hk_U_gr100 hk_S_gr100 rel_hShU_gr100
/*  
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
  hk_U_gr100 |         74   -.6423762    1.006957  -4.026814   .5305467
  hk_S_gr100 |         74    6.006774    2.313008   1.201828   12.79225
rel_hShU~100 |         74    6.695047    2.204581   1.975896    12.8055
*/


/********  wu ws  *********/
sort BLcode year

by BLcode: gen spr_mp_gr30 = spr_mp / spr_mp[_n-1]
by BLcode: gen spr_mp_gr = (spr_mp_gr30^(1/30))-1
gen spr_mp_gr100 = spr_mp_gr*100
label variable spr_mp_gr100 "g(Ws/Wu)"
drop spr_mp_gr30 spr_mp_gr 

/********  Skill Premium times h_S  *********/
by BLcode: gen SPhS_BKA_gr30 = SPhS_BKA / SPhS_BKA[_n-1]
by BLcode: gen SPhS_BKA_gr = (SPhS_BKA_gr30^(1/30))-1
gen SPhS_BKA_gr100 = SPhS_BKA_gr*100
label variable SPhS_BKA_gr100 "g(SP*hS)"
drop SPhS_BKA_gr30 SPhS_BKA_gr 

/********  HK growth *********/
/* 	(A) h_A_14   
	BK  hk_bk 
	BJ  hk_bj_14
*/

* (A) *
by BLcode: gen h_A_14_gr30 = h_A_14 / h_A_14[_n-1]
by BLcode: gen h_A_14_gr = (h_A_14_gr30^(1/30))-1
gen h_A_14_gr100 = h_A_14_gr*100
label variable h_A_14_gr100 "gh (CES)"
drop h_A_14_gr30 h_A_14_gr 

* (BK) *
by BLcode: gen hk_bk_gr30 = hk_bk / hk_bk[_n-1]
by BLcode: gen hk_bk_gr = (hk_bk_gr30^(1/30))-1
gen hk_bk_gr100 = hk_bk_gr*100
label variable hk_bk_gr100 "gh BK*"
drop hk_bk_gr30 hk_bk_gr 

* (BK_X) *
sort BLcode year

by BLcode: gen hk_bkX_gr30 = hk_bkX / hk_bkX[_n-1]
by BLcode: gen hk_bkX_gr = (hk_bkX_gr30^(1/30))-1
gen hk_bkX_gr100 = hk_bkX_gr*100
label variable hk_bkX_gr100 "gh BK"
drop hk_bkX_gr30 hk_bkX_gr 

* (BK-US) *
by BLcode: gen hk_bk_US_gr30 = hk_bk_US / hk_bk_US[_n-1]
by BLcode: gen hk_bk_US_gr = (hk_bk_US_gr30^(1/30))-1
gen hk_bk_US_gr100 = hk_bk_US_gr*100
label variable hk_bk_US_gr100 "gh BK-A"
drop hk_bk_US_gr30 hk_bk_US_gr 

* (BJ) *
by BLcode: gen hk_bj_14_gr30 = hk_bj_14 / hk_bj_14[_n-1]
by BLcode: gen hk_bj_14_gr = (hk_bj_14_gr30^(1/30))-1
gen hk_bj_14_gr100 = hk_bj_14_gr*100
label variable hk_bj_14_gr100 "gh BJ"
drop hk_bj_14_gr30 hk_bj_14_gr 



/********  A growth *********/
sort BLcode year

* (A) *
by BLcode: gen Au_A_gr30 = Au_A / Au_A[_n-1]
by BLcode: gen Au_A_gr = (Au_A_gr30^(1/30))-1
gen Au_A_gr100 = Au_A_gr*100
label variable Au_A_gr100 "gAu (CES)"
drop Au_A_gr30 Au_A_gr 

gen test_Au_A = ghgA - h_A_14_gr100
sum Au_A_gr100 test_Au_A
scatter Au_A_gr100 test_Au_A /* must be 45o line */
drop test_Au_A

sort BLcode year

by BLcode: gen As_A_gr30 = As_A / As_A[_n-1]
by BLcode: gen As_A_gr = (As_A_gr30^(1/30))-1
gen As_A_gr100 = As_A_gr*100
label variable As_A_gr100 "gAs (CES)"
drop As_A_gr30 As_A_gr 


by BLcode: gen rel_AsAu_gr30 = rel_AsAu / rel_AsAu[_n-1]
by BLcode: gen rel_AsAu_gr = (rel_AsAu_gr30^(1/30))-1
gen rel_AsAu_gr100 = rel_AsAu_gr*100
label variable rel_AsAu_gr100 "g(As/Au) (CES)"
drop rel_AsAu_gr30 rel_AsAu_gr 


* CES second term *
by BLcode: gen SBhS_CES_gr30 = SBhS_CES / SBhS_CES[_n-1]
by BLcode: gen SBhS_CES_gr = (SBhS_CES_gr30^(1/30))-1
gen SBhS_CES_gr100 = SBhS_CES_gr*100
label variable SBhS_CES_gr100 "g(SB*hS) CES"
drop SBhS_CES_gr30 SBhS_CES_gr 



* (BK-US) *
sort BLcode year

by BLcode: gen Au_bk_gr30 = Au_bk / Au_bk[_n-1]
by BLcode: gen Au_bk_gr = (Au_bk_gr30^(1/30))-1
gen Au_bk_gr100 = Au_bk_gr*100
label variable Au_bk_gr100 "gAu (BK-A)"
drop Au_bk_gr30 Au_bk_gr 

gen test_bku_bk = ghgA - hk_bk_US_gr100
sum Au_bk_gr100 test_bku_bk
scatter Au_bk_gr100 test_bku_bk /* must be 45o line */
drop test_bku_bk

by BLcode: gen As_bk_gr30 = As_bk / As_bk[_n-1]
by BLcode: gen As_bk_gr = (As_bk_gr30^(1/30))-1
gen As_bk_gr100 = As_bk_gr*100
label variable As_bk_gr100 "gAs (BK-A)"
drop As_bk_gr30 As_bk_gr 





* (BK) *
sort BLcode year

by BLcode: gen A_bk_gr30 = A_bk / A_bk[_n-1]
by BLcode: gen A_bk_gr = (A_bk_gr30^(1/30))-1
gen A_bk_gr100 = A_bk_gr*100
label variable A_bk_gr100 "gA BK*"
drop A_bk_gr30 A_bk_gr 

gen test_A_bk = ghgA - hk_bk_gr100
sum A_bk_gr100 test_A_bk
scatter A_bk_gr100 test_A_bk
drop test_A_bk


* (BK-original) *
sort BLcode year

by BLcode: gen A_bkX_gr30 = A_bkX / A_bkX[_n-1]
by BLcode: gen A_bkX_gr = (A_bkX_gr30^(1/30))-1
gen A_bkX_gr100 = A_bkX_gr*100
label variable A_bkX_gr100 "gA BK"
drop A_bkX_gr30 A_bkX_gr 

gen test_A_bkX = ghgA - hk_bk_gr100
sum A_bkX_gr100 test_A_bkX
scatter A_bkX_gr100 test_A_bkX
drop test_A_bkX


* (BJ) *
sort BLcode year

by BLcode: gen A_bj_gr30 = A_bj / A_bj[_n-1]
by BLcode: gen A_bj_gr = (A_bj_gr30^(1/30))-1
gen A_bj_gr100 = A_bj_gr*100
label variable A_bj_gr100 "gA BJ"
drop A_bj_gr30 A_bj_gr 

gen test_A_bj = ghgA - hk_bj_14_gr100
sum A_bj_gr100 test_A_bj
scatter A_bj_gr100 test_A_bj
drop test_A_bj




* 1-tau *
sort BLcode year

by BLcode: gen d_tauC = tauC - tauC[_n-1]
label variable d_tauC "Delta(tau)"
*label variable d_tauC "{&delta}(1-{&tau})"

by BLcode: gen d_su = su - su[_n-1]
label variable d_su "Delta(su)"

by BLcode: gen d_ss = ss - ss[_n-1]
label variable d_ss "Delta(ss)"

drop if missing(ghgA) /* (74 observations deleted) */

saveold "Output/BKSK_growth.dta", replace /* 74 countries */


*********************************************************

/* prepares the final dataset */

use "Output/BKSK_growth.dta", clear	

/* merging with bkenrol */
merge m:m BLcode using "Output/LeeLee_bkschool.dta"
	keep if _merge==3	
	drop _merge
	sort WBcode year
	keep BLcode WBcode country bkschool gdpWAP_gr100 rknaWAP_gr100 ghgA hk_U_gr100 hk_S_gr100 rel_hShU_gr100 spr_mp_gr100 SPhS_BKA_gr100 h_A_14_gr100 hk_bk_gr100 hk_bkX_gr100 hk_bj_14_gr100 Au_A_gr100 As_A_gr100 rel_AsAu_gr100 SBhS_CES_gr100 hk_bk_US_gr100 Au_bk_gr100 As_bk_gr100 A_bk_gr100 A_bkX_gr100 A_bj_gr100 d_tauC d_su d_ss 
saveold "Output/BKSK_dataset.dta", replace


/* saves list of 74 countries in the final dataset */
use "Output/BKSK_dataset.dta", clear	
	keep BLcode WBcode country
saveold "Output/BKSK_countries.dta", replace
	