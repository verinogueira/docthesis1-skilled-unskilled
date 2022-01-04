/* Create series for duration of secondary education */
*** uses World Bank Indicators data ***
*** https://data.worldbank.org/indicator/SE.SEC.DURS ***
 *** choose "download -> Excel" at the end of RHS menu ***
 *** save file in Input directory ***
 *** rename it to "WB_duration_raw.xlsx" ***

 


/* import WB data */
import excel "Input\WB_duration_raw.xlsx", sheet("Data") cellrange(A4:BM270) firstrow clear
	drop IndicatorName IndicatorCode
* Stata does not accept numbers as var names -> years are in var labels *
* first year available is 1970, var named "O"
	drop E F G H I J K L M N
	sort O
* 19 countries have no information in 1970 *
* among those, only SDN (Sudan) is in PWT_LL dataset
	drop if missing(O)
	keep CountryCode O AI
	sort CountryCode
*** first country "ABW" ***	
saveold "Output\WB_duration_raw.dta", replace


/* transpose to construct the series */
use "Output\WB_duration_raw.dta", clear
	keep if CountryCode=="ABW"
	replace CountryCode="Duration"
sxpose, force clear firstnames format(%12.0g) 
	destring, replace
	gen CountryCode="ABW"
	gen year=_n + 1969
	replace year=1990 if year==1971
	order CountryCode year Duration
saveold "Output\temp_append.dta", replace

#delimit ;
foreach c in	"AFE" 	"AFG" 	"AFW" 	"AGO" 	"ALB" 	"AND" 	"ARB" 	"ARE" 	"ARG" 	"ARM" 	"ATG" 	"AUS" 	"AUT" 	"AZE" 	"BDI" 	"BEL" 	"BEN" 	"BFA" 	"BGD" 	"BGR" 	"BHR" 	"BHS" 	"BIH" 	"BLR" 	"BLZ" 	"BMU" 	"BOL" 	"BRA" 	"BRB" 	"BRN" 	"BTN" 	"BWA" 	"CAF" 	"CAN" 	"CEB" 	"CHE" 	"CHL" 	"CHN" 	"CIV" 	"CMR" 	"COD" 	"COG" 	"COL" 	"COM" 	"CPV" 	"CRI" 	"CSS" 	"CUB" 	"CYM" 	"CYP" 	"CZE" 	"DEU" 	"DJI" 	"DMA" 	"DNK" 	"DOM" 	"DZA" 	"EAP" 	"EAR" 	"EAS" 	"ECA" 	"ECS" 	"ECU" 	"EGY" 	"EMU" 	"ERI" 	"ESP" 	"EST" 	"ETH" 	"EUU" 	"FCS" 	"FIN" 	"FJI" 	"FRA" 	"FSM" 	"GAB" 	"GBR" 	"GEO" 	"GHA" 	"GIB" 	"GIN" 	"GMB" 	"GNB" 	"GNQ" 	"GRC" 	"GRD" 	"GTM" 	"GUY" 	"HIC" 	"HKG" 	"HND" 	"HPC" 	"HRV" 	"HTI" 	"HUN" 	"IBD" 	"IBT" 	"IDA" 	"IDB" 	"IDN" 	"IDX" 	"IND" 	"IRL" 	"IRN" 	"IRQ" 	"ISL" 	"ISR" 	"ITA" 	"JAM" 	"JOR" 	"JPN" 	"KAZ" 	"KEN" 	"KGZ" 	"KHM" 	"KIR" 	"KNA" 	"KOR" 	"KWT" 	"LAC" 	"LAO" 	"LBN" 	"LBR" 	"LBY" 	"LCA" 	"LCN" 	"LDC" 	"LIC" 	"LIE" 	"LKA" 	"LMC" 	"LMY" 	"LSO" 	"LTE" 	"LTU" 	"LUX" 	"LVA" 	"MAC" 	"MAR" 	"MCO" 	"MDA" 	"MDG" 	"MDV" 	"MEA" 	"MEX" 	"MHL" 	"MIC" 	"MKD" 	"MLI" 	"MLT" 	"MMR" 	"MNA" 	"MNE" 	"MNG" 	"MOZ" 	"MRT" 	"MUS" 	"MWI" 	"MYS" 	"NAC" 	"NAM" 	"NER" 	"NGA" 	"NIC" 	"NLD" 	"NOR" 	"NPL" 	"NRU" 	"NZL" 	"OED" 	"OMN" 	"OSS" 	"PAK" 	"PAN" 	"PER" 	"PHL" 	"PLW" 	"PNG" 	"POL" 	"PRE" 	"PRK" 	"PRT" 	"PRY" 	"PSE" 	"PST" 	"QAT" 	"ROU" 	"RUS" 	"RWA" 	"SAS" 	"SAU" 	"SEN" 	"SGP" 	"SLB" 	"SLE" 	"SLV" 	"SMR" 	"SOM" 	"SRB" 	"SSA" 	"SSF" 	"SST" 	"STP" 	"SUR" 	"SVK" 	"SVN" 	"SWE" 	"SWZ" 	"SYC" 	"SYR" 	"TCA" 	"TCD" 	"TEA" 	"TEC" 	"TGO" 	"THA" 	"TJK" 	"TKM" 	"TLA" 	"TLS" 	"TMN" 	"TON" 	"TSA" 	"TSS" 	"TTO" 	"TUN" 	"TUR" 	"TUV" 	"TZA" 	"UGA" 	"UKR" 	"UMC" 	"URY" 	"USA" 	"UZB" 	"VCT" 	"VEN" 	"VGB" 	"VNM" 	"VUT" 	"WLD" 	"WSM" 	"YEM" 	"ZAF" 	"ZMB" 	"ZWE" 
 {;
	use "Output\WB_duration_raw.dta", clear;
	keep if CountryCode=="`c'";
	replace CountryCode="Duration";
sxpose, force clear firstnames format(%12.0g);
	destring, replace;
	gen CountryCode="`c'";
	gen year=_n + 1969;
	replace year=1990 if year==1971;
	order CountryCode year Duration;
	append using "Output\temp_append.dta";
	saveold "Output\temp_append.dta", replace;
	clear all;
};
#delimit cr


/* finalise file */
use "Output\temp_append.dta", replace
	sort CountryCode year
		replace CountryCode="ROM" if CountryCode=="MDA" /* Moldova */
		replace CountryCode="SER" if CountryCode=="SRB" /* Serbia */
	rename CountryCode WBcode
	replace year=1960 if year==1970 /* explained in the paper */
saveold "Output\WB_duration.dta", replace

