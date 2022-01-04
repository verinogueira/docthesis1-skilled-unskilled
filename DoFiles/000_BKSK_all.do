/* Basic setting up */
cls
clear all
set more off

* set current directory *
cd "C:\..."


/* From raw data */
run "DoFiles/0_BKSK_aggregate.do"
run "DoFiles/1_BKSK_MPmincer.do"
run "DoFiles/2_BKSK_duration.do"

/* Preparing data */
run "DoFiles/3_BKSK_cohorts.do"
run "DoFiles/4_BKSK_hUhS.do"
run "DoFiles/5_BKSK_wages.do"
run "DoFiles/6_BKSK_technology.do"

/* Finalizing dataset */
run "DoFiles/7_BKSK_growth.do"

/* Figures and Tables */
*** main body ***
run "DoFiles/8_BKSK_exhibits.do"
*** sensitivity test ***
run "DoFiles/9_0_BKSK_sensitivity.do"
*** appendix ***
run "DoFiles/BKSK_appendix.do"

