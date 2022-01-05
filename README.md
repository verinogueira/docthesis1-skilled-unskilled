# docthesis1-skilled-unskilled: README
--------

## Overview


The code in this replication package constructs the analysis of ``Skilled and unskilled labour: Are they worth their weight in growth?'', which is the first chapter of my doctoral thesis available at the University of Essex's [Repository](http://repository.essex.ac.uk/31206/). Data sources are Lee and Lee (2016), Barro and Lee (2001), The World Bank (2017), Feenstra, Inklaar, and Timmer (2015). The model is calibrated using parameters from Bils and Klenow (2000), Montenegro and Patrinos (2014), Acemoglu and Autor (2011) and Ciccone and Peri (2005). All sources are presented in the paper too. 

The construction of the dataset and the estimations use Stata. Code for data cleaning and analysis is provided as part of the replication package. The main file runs all of the code to generate the data for the 10 figures and 3 tables in the paper. The replicator can expect the code to run for a couple of minutes.

This README complies to the structure and content that have been suggested by [Endorsers](https://github.com/social-science-data-editors/template_README/blob/development/Endorsers.md) of several journals of Social Sciences. Their template is available [here](https://github.com/social-science-data-editors/template_README/blob/master/template-README.md).

--------
## Data Availability and Provenance Statements

### Rights, license and availability

- [X] I certify that the author of the manuscript have legitimate access to and permission to use the data used in this manuscript. 
- [X] The data are licensed under a GNU General Public License v3.0. See LICENSE.txt for details.
- [X] All data **are** publicly available.


### Data Sources


#### Lee and Lee (2016)

Data on school enrolment comes from Lee and Lee (2016), hereafter Lee-Lee, which
covers 111 countries in five-year intervals, from 1820 to 2010. The version 1.0 used
in this chapter comes from the most recent update available. The sample selected
is restricted to the male population to comply with the Mincerian returns used. 

Data can be downloaded from https://github.com/barrolee/BarroLeeDataSet/blob/master/LeeLee/LeeLee_v1.dta. 
Save the file in the directory `Input`. 

Datafile: `Input/LeeLee_v1.dta` (not provided)



#### Barro and Lee (2001)

The bulk of the data on schooling comes from Barro and Lee (2001), hereafter Barro-
Lee, presenting educational data for 146 countries, ranging from 1950 to 2010. The
version used is the 2.1. Once more, only the male population subsample was selected.

Data can be downloaded from https://barrolee.github.io/BarroLeeDataSet/BLData/BL2013_M_v2.2.dta. 
Save the file in the directory `Input`. 

Datafile: `Input/BL2013_M_v2.2.dta` (not provided)

#### World Bank Indicators

Additionally, information on the theoretical duration of educational levels was retrieved
from the World Bank Indicators platform (The World Bank, 2017). The data
are provided by the United Nations Educational, Scientific, and Cultural Organization
(UNESCO) Institute for Statistics is available yearly for 247 countries since 1970. I use
the variable for the number of grades (years) in secondary education (Duration).


Secondary education, duration (years): https://data.worldbank.org/indicator/SE.SEC.DURS
Choose "Download -> Excel" at the end of the menu on the right-hand side. Save file in `Input`
directory. Rename it `WB_duration_raw.xlsx`.

Datafile: `Input/WB_duration_raw.xlsx` (provided)

#### Penn World Table

Finally, the national accounting variables are collected from version (9.0) of the
Penn World Table (PWT) (Feenstra, Inklaar, and Timmer, 2015). 


Data can be downloaded from https://www.rug.nl/ggdc/docs/pwt90.dta. 
Save the file in the directory `Input`. 

Datafile: `Input/pwt90.dta` (not provided)

#### Bils and Klenow (2000)

The coefficients of the Mincerian equations are the cross-country averages
as reported and used by Bils and Klenow's (2000) Table B1. The values equal 9.9 per cent for
the return to schooling, and 0.0512 and -0.00071 per cent for the experience-earnings
profile level and squared, respectively. These are typed directly into the equations of the code.

##### Montenegro and Patrinos (2014)

The Mincerian coefficients used to calculate skill premia come from Montenegro and Patrinos (2014). The paper's Annex Table 1 is converted to Excel and available in the directory `Input`. Please cite the original data providers when using this data. 

Datafile: `Input/MP_mincer.xls` (provided)

##### Elasticity of substitution

The values for the parameter representing the elasticity of substitution between unskilled and
skilled labour come from Acemoglu and Autor (2011) and Ciccone and Peri (2005). The range between 1 and 2 used in the sensitivity analysis derives from the former while the standard value of 1.4 is obtained in the latter.



******

# WORK IN PROCESS - original template below here

******





Dataset list
------------


| Data file | Source | Notes    |Provided |
|-----------|--------|----------|---------|
| `Input/LeeLee_v1.dta` | Lee and Lee (2016) | School enrolment | No |
| `Input/BL2013_M_v2.2.dta` | Barro and Lee (2001) | Schooling  | No |
| `Input/pwt90.dta` | Penn World Table v9.0 | As per terms of use | No |
| `Input/WB_duration_raw.xlsx` | Unesco/WB | Duration of secondary (SE.SEC.DURS) | Yes |
| `Input/MP_mincer.xls` | Montenegro and Patrinos (2014) | Annex Table 1 | Yes |
| `Output/WB_duration_raw.dta` | Unesco/WB | Cleaned WB data | Yes |
| `Input/MP_mincer.xls` | Montenegro and Patrinos (2014) | Latest coefficient for each country | Yes |


Computational requirements
---------------------------

> INSTRUCTIONS: In general, the specific computer code used to generate the results in the article will be within the repository that also contains this README. However, other computational requirements - shared libraries or code packages, required software, specific computing hardware - may be important, and is always useful, for the goal of replication. Some example text follows. 

> INSTRUCTIONS: We strongly suggest providing setup scripts that install/set up the environment. Sample scripts for [Stata](https://github.com/gslab-econ/template/blob/master/config/config_stata.do),  [R](https://github.com/labordynamicsinstitute/paper-template/blob/master/programs/global-libraries.R), [Julia](https://github.com/labordynamicsinstitute/paper-template/blob/master/programs/packages.jl) are easy to set up and implement. Specific software may have more sophisticated tools: [Python](https://pip.pypa.io/en/stable/user_guide/#ensuring-repeatability), [Julia](https://julia.quantecon.org/more_julia/tools_editors.html#Package-Environments).

### Software Requirements

> INSTRUCTIONS: List all of the software requirements, up to and including any operating system requirements, for the entire set of code. It is suggested to distribute most dependencies together with the replication package if allowed, in particular if sourced from unversioned code repositories, Github repos, and personal webpages. In all cases, list the version *you* used. 

- Stata (code was last run with version 15)
  - `estout` (as of 2018-05-12)
  - `rdrobust` (as of 2019-01-05)
  - the program "`0_setup.do`" will install all dependencies locally, and should be run once.
- Python 3.6.4
  - `pandas` 0.24.2
  - `numpy` 1.16.4
  - the file "`requirements.txt`" lists these dependencies, please run "`pip install -r requirements.txt`" as the first step. See [https://pip.pypa.io/en/stable/user_guide/#ensuring-repeatability](https://pip.pypa.io/en/stable/user_guide/#ensuring-repeatability) for further instructions on creating and using the "`requirements.txt`" file.
- Intel Fortran Compiler version 20200104
- Matlab (code was run with Matlab Release 2018a)
- R 3.4.3
  - `tidyr` (0.8.3)
  - `rdrobust` (0.99.4)
  - the file "`0_setup.R`" will install all dependencies (latest version), and should be run once prior to running other programs.

Portions of the code use bash scripting, which may require Linux.

Portions of the code use Powershell scripting, which may require Windows 10 or higher.

### Controlled Randomness

> INSTRUCTIONS: Some estimation code uses random numbers, almost always provided by pseudorandom number generators (PRNGs). For reproducibility purposes, these should be provided with a deterministic seed, so that the sequence of numbers provided is the same for the original author and any replicators. While this is not always possible, it is a requirement by many journals' policies. The seed should be set once, and not use a time-stamp. If using parallel processing, special care needs to be taken. If using multiple programs in sequence, care must be taken on how to call these programs, ideally from a main program, so that the sequence is not altered.

- [ ] Random seed is set at line _____ of program ______

### Memory and Runtime Requirements

> INSTRUCTIONS: Memory and compute-time requirements may also be relevant or even critical. Some example text follows. It may be useful to break this out by Table/Figure/section of processing. For instance, some estimation routines might run for weeks, but data prep and creating figures might only take a few minutes.

#### Summary

Approximate time needed to reproduce the analyses on a standard (CURRENT YEAR) desktop machine:

- [ ] <10 minutes
- [ ] 10-60 minutes
- [ ] 1-8 hours
- [ ] 8-24 hours
- [ ] 1-3 days
- [ ] 3-14 days
- [ ] > 14 days
- [ ] Not feasible to run on a desktop machine, as described below.

#### Details

The code was last run on a **4-core Intel-based laptop with MacOS version 10.14.4**. 

Portions of the code were last run on a **32-core Intel server with 1024 GB of RAM, 12 TB of fast local storage**. Computation took 734 hours. 

Portions of the code were last run on a **12-node AWS R3 cluster, consuming 20,000 core-hours**.  

> INSTRUCTIONS: Identifiying hardware and OS can be obtained through a variety of ways:
> Some of these details can be found as follows:
>
> - (Windows) by right-clicking on "This PC" in File Explorer and choosing "Properties"
> - (Mac) Apple-menu > "About this Mac"
> - (Linux) see code in [tools/linux-system-info.sh](https://github.com/AEADataEditor/replication-template/blob/master/tools/linux-system-info.sh)`


Description of programs/code
----------------------------

> INSTRUCTIONS: Give a high-level overview of the program files and their purpose. Remove redundant/ obsolete files from the Replication archive.

- Programs in `programs/01_dataprep` will extract and reformat all datasets referenced above. The file `programs/01_dataprep/main.do` will run them all.
- Programs in `programs/02_analysis` generate all tables and figures in the main body of the article. The program `programs/02_analysis/main.do` will run them all. Each program called from `main.do` identifies the table or figure it creates (e.g., `05_table5.do`).  Output files are called appropriate names (`table5.tex`, `figure12.png`) and should be easy to correlate with the manuscript.
- Programs in `programs/03_appendix` will generate all tables and figures  in the online appendix. The program `programs/03_appendix/main-appendix.do` will run them all. 
- Ado files have been stored in `programs/ado` and the `main.do` files set the ADO directories appropriately. 
- The program `programs/00_setup.do` will populate the `programs/ado` directory with updated ado packages, but for purposes of exact reproduction, this is not needed. The file `programs/00_setup.log` identifies the versions as they were last updated.
- The program `programs/config.do` contains parameters used by all programs, including a random seed. Note that the random seed is set once for each of the two sequences (in `02_analysis` and `03_appendix`). If running in any order other than the one outlined below, your results may differ.

### (Optional, but recommended) License for Code

> INSTRUCTIONS: Most journal repositories provide for a default license, but do not impose a specific license. Authors should actively select a license. This should be provided in a LICENSE.txt file, separately from the README, possibly combined with the license for any data provided. Some code may be subject to inherited license requirements, i.e., the original code author may allow for redistribution only if the code is licensed under specific rules - authors should check with their sources. For instance, some code authors require that their article describing the econometrics of the package be cited. Licensing can be complex. Some non-legal guidance may be found [here](https://social-science-data-editors.github.io/guidance/Licensing_guidance.html).

The code is licensed under a MIT/BSD/GPL [choose one!] license. See [LICENSE.txt](LICENSE.txt) for details.

Instructions to Replicators
---------------------------

> INSTRUCTIONS: The first two sections ensure that the data and software necessary to conduct the replication have been collected. This section then describes a human-readable instruction to conduct the replication. This may be simple, or may involve many complicated steps. It should be a simple list, no excess prose. Strict linear sequence. If more than 4-5 manual steps, please wrap a main program/Makefile around them, in logical sequences. Examples follow.

- Edit `programs/config.do` to adjust the default path
- Run `programs/00_setup.do` once on a new system to set up the working environment. 
- Download the data files referenced above. Each should be stored in the prepared subdirectories of `data/`, in the format that you download them in. Do not unzip. Scripts are provided in each directory to download the public-use files. Confidential data files requested as part of your FSRDC project will appear in the `/data` folder. No further action is needed on the replicator's part.
- Run `programs/01_main.do` to run all steps in sequence.

### Details

- `programs/00_setup.do`: will create all output directories, install needed ado packages. 
   - If wishing to update the ado packages used by this archive, change the parameter `update_ado` to `yes`. However, this is not needed to successfully reproduce the manuscript tables. 
- `programs/01_dataprep`:  
   - These programs were last run at various times in 2018. 
   - Order does not matter, all programs can be run in parallel, if needed. 
   - A `programs/01_dataprep/main.do` will run them all in sequence, which should take about 2 hours.
- `programs/02_analysis/main.do`.
   - If running programs individually, note that ORDER IS IMPORTANT. 
   - The programs were last run top to bottom on July 4, 2019.
- `programs/03_appendix/main-appendix.do`. The programs were last run top to bottom on July 4, 2019.
- Figure 1: The figure can be reproduced using the data provided in the folder “2_data/data_map”, and ArcGIS Desktop (Version 10.7.1) by following these (manual) instructions:
  - Create a new map document in ArcGIS ArcMap, browse to the folder
“2_data/data_map” in the “Catalog”, with files  "provinceborders.shp", "lakes.shp", and "cities.shp". 
  - Drop the files listed above onto the new map, creating three separate layers. Order them with "lakes" in the top layer and "cities" in the bottom layer.
  - Right-click on the cities file, in properties choose the variable "health"... (more details)

List of tables and programs
---------------------------

> INSTRUCTIONS: Your programs should clearly identify the tables and figures as they appear in the manuscript, by number. Sometimes, this may be obvious, e.g. a program called "`table1.do`" generates a file called `table1.png`. Sometimes, mnemonics are used, and a mapping is necessary. In all circumstances, provide a list of tables and figures, identifying the program (and possibly the line number) where a figure is created.
>
> NOTE: If the public repository is incomplete, because not all data can be provided, as described in the data section, then the list of tables should clearly indicate which tables, figures, and in-text numbers can be reproduced with the public material provided.

The provided code reproduces:

- [ ] All numbers provided in text in the paper
- [ ] All tables and figures in the paper
- [ ] Selected tables and figures in the paper, as explained and justified below.


| Figure/Table #    | Program                  | Line Number | Output file                      | Note                            |
|-------------------|--------------------------|-------------|----------------------------------|---------------------------------|
| Table 1           | 02_analysis/table1.do    |             | summarystats.csv                 ||
| Table 2           | 02_analysis/table2and3.do| 15          | table2.csv                       ||
| Table 3           | 02_analysis/table2and3.do| 145         | table3.csv                       ||
| Figure 1          | n.a. (no data)           |             |                                  | Source: Herodus (2011)          |
| Figure 2          | 02_analysis/fig2.do      |             | figure2.png                      ||
| Figure 3          | 02_analysis/fig3.do      |             | figure-robustness.png            | Requires confidential data      |

## References

> INSTRUCTIONS: As in any scientific manuscript, you should have proper references. For instance, in this sample README, we cited "Ruggles et al, 2019" and "DESE, 2019" in a Data Availability Statement. The reference should thus be listed here, in the style of your journal:

Steven Ruggles, Steven M. Manson, Tracy A. Kugler, David A. Haynes II, David C. Van Riper, and Maryia Bakhtsiyarava. 2018. "IPUMS Terra: Integrated Data on Population and Environment: Version 2 [dataset]." Minneapolis, MN: *Minnesota Population Center, IPUMS*. https://doi.org/10.18128/D090.V2

Department of Elementary and Secondary Education (DESE), 2019. "Student outcomes database [dataset]" *Massachusetts Department of Elementary and Secondary Education (DESE)*. Accessed January 15, 2019.

U.S. Bureau of Economic Analysis (BEA). 2016. “Table 30: "Economic Profile by County, 1969-2016.” (accessed Sept 1, 2017).

Inglehart, R., C. Haerpfer, A. Moreno, C. Welzel, K. Kizilova, J. Diez-Medrano, M. Lagos, P. Norris, E. Ponarin & B. Puranen et al. (eds.). 2014. World Values Survey: Round Six - Country-Pooled Datafile Version: http://www.worldvaluessurvey.org/WVSDocumentationWV6.jsp. Madrid: JD Systems Institute.

---

## Acknowledgements

Some content on this page was copied from [Hindawi](https://www.hindawi.com/research.data/#statement.templates). Other content was adapted  from [Fort (2016)](https://doi.org/10.1093/restud/rdw057), Supplementary data, with the author's permission.
