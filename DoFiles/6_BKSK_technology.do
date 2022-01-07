/* calculate the technology terms */



use "Output/BKSK_wages.dta", clear


/* human capital data */
sort WBcode year
	merge m:m WBcode year using "Output/BKSK_humancapital.dta" /* .dta created in 0_BKSK_aggregate.do */

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                            66
        from master                         0  (_merge==1)
        from using                         66  (_merge==2)

    matched                               220  (_merge==3)
    -----------------------------------------
*/
    drop if _merge<3
	drop _merge

sort WBcode year




/* PWT data */
sort WBcode year
	merge m:m WBcode year using "Output/BKSK_aggregate.dta" /* .dta created in 0_BKSK_aggregate.do */

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                            70
        from master                         8  (_merge==1)
        from using                         62  (_merge==2)

    matched                               212  (_merge==3)
    -----------------------------------------
*/
    drop if _merge<3
	drop _merge

sort WBcode year



/* variables per BK's WORKING-AGE POPULATION 20-60 */
gen gdpWAP = rgdpna/ total_pop
gen rknaWAP = rkna/ total_pop

label variable gdpWAP "Real GDP per person WAP"
label variable rknaWAP "Capital stock per person WAP"


saveold "Output/BKSK_wages_techn.dta", replace	




use "Output/BKSK_wages_techn.dta", clear



*** calculate Solow residual ***
gen alpha = 1/3

*** BK ***
gen A_bk = gdpWAP^(1/(1-alpha))*rknaWAP^(-alpha/(1-alpha))*hk_bk^(-1)
label variable A_bk "BK's techonology term (hu+hs)"

gen A_bkX = gdpWAP^(1/(1-alpha))*rknaWAP^(-alpha/(1-alpha))*hk_bkX^(-1)
label variable A_bkX "BK's techonology term (original)"
*****************************************************

*** Ben Jones (2014) ***
gen A_bj = gdpWAP^(1/(1-alpha))*rknaWAP^(-alpha/(1-alpha))*hk_bj_14^(-1)
label variable A_bj "BJ's techonology term"
*****************************************************



*** (CES) ***

/* calculate ratio of technology terms */
gen rel_hShU = hk_S/hk_U
gen lnrel_hShU = ln(rel_hShU)
label variable lnrel_hShU "Log of Relative Supply of Skills"

gen lnrel_AsAu = (sigma*lnspr_mp+lnrel_hShU)/(sigma - 1)
label variable lnrel_AsAu "Log of Relative Technology Terms As/Au"
gen rel_AsAu = exp(lnrel_AsAu)
label variable rel_AsAu "Relative Technology Terms As/Au (CES)"



/* * * pinn down Au * * */
gen Au_A = gdpWAP^(1/(1-alpha)) * rknaWAP^(-alpha/(1-alpha)) * (hk_U^((sigma-1)/sigma) + (rel_AsAu*hk_S)^((sigma-1)/sigma))^(-sigma/(sigma-1)) 

/* * * pinn down As * * */
gen As_A = rel_AsAu*Au_A

  
/* calculate aggregate HK */
gen h_A_14 = ((hk_U^((sigma -1)/sigma)) + ((rel_AsAu*hk_S)^((sigma -1)/sigma)))^(sigma/(sigma - 1))
label variable h_A_14 "h: aggregation (CES)"


*** Skill Bias * hS ***
gen SBhS_CES = rel_AsAu*hk_S
sum Au_A h_A_14 hk_U SBhS_CES rel_AsAu hk_S


*****************************************************



******* (BK) With tech terms *******

/* calculate ratio of technology terms */
   * * * rel_AsAu = spr_mp * * *

/* calculate aggregate HK */
gen hk_bk_US = hk_U+spr_mp*hk_S
label variable hk_bk_US "h: aggregation (BK-A)"
   
/* * * pinn down Au * * */
gen Au_bk = gdpWAP^(1/(1-alpha))*rknaWAP^(-alpha/(1-alpha))*(hk_bk_US)^(-1)

/* * * pinn down As * * */
gen As_bk = spr_mp*Au_bk
*****************************************************

*** Skill Premium * hS ***
gen SPhS_BKA = spr_mp*hk_S
sum hk_bk_US hk_U spr_mp hk_S SPhS_BKA

/* 
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
    hk_bk_US |        172     3.73905     1.41075   2.253345   11.96899
        hk_U |        172    2.475896    .5297651   .5652269   3.887581
      spr_mp |        172    1.143129    .1707038   1.000274   2.065378
        hk_S |        172     .961652    1.150421   .0014459    5.52139
    SPhS_BKA |        172    1.263155     1.76633   .0014463   11.40376
*/

sum h_A_14 hk_bk_US Au_A Au_bk
/* 

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      h_A_14 |        172     226.968     1950.25   2.256965   24696.97
    hk_bk_US |        172     3.73905     1.41075   2.253345   11.96899
        Au_A |        160    1.745218     1.50375   .0025049   8.029451
       Au_bk |        160    3.984271    2.760577   .3372761    15.2474
*/

  

*drop if missing(Au_bk)	




saveold "Output/BKSK_wages_techn.dta", replace	
