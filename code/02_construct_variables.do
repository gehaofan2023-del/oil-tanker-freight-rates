/*******************************************
Project: Oil Tanker Freight Rates and Brokerage Activity
File: 02_construct_variables.do
Purpose: Merge cleaned datasets and construct variables for analysis
Author: Haofan Ge
********************************************/

clear all
set more off

//-------------------------------
* 1. Set paths
//-------------------------------

global root "."
global data "$root/data"
global processed "$data/processed"

//--------------------------------
* 2. Load cleaned demand data
//--------------------------------

use "$processed/demand_clean.dta", clear

* Check data structure
describe
summarize
list in 1/5

//--------------------------------
* 3. Merge oil price data
//--------------------------------

merge 1:1 mdate using "$processed/oil_price_clean.dta"

* Check merge result
tab _merge

* Keep matched and master observations as needed
drop _merge

//---------------------------------
* 4. Set monthly time-series structure
//---------------------------------

format mdate %tm
sort mdate
tsset mdate

//----------------------------------
* 5. Construct log variables
//----------------------------------

gen ln_demand = ln(demand) if demand > 0
gen ln_oil_price = ln(oil_price) if oil_price > 0

label variable ln_demand "Log of monthly oil demand"
label variable ln_oil_price "Log of oil price"

//----------------------------------
* 6. Construct first differences
//----------------------------------

gen d_ln_demand = D.ln_demand
gen d_ln_oil_price = D.ln_oil_price

label variable d_ln_demand "First difference of log monthly oil demand"
label variable d_ln_oil_price "First difference of log oil price"

//----------------------------------
* 7. Construct lagged variables
//----------------------------------

gen L1_ln_demand = L1.ln_demand
gen L1_ln_oil_price = L1.ln_oil_price

label variable L1_ln_demand "One-month lag of log monthly oil demand"
label variable L1_ln_oil_price "One-month lag of log oil price"

//----------------------------------
* 8. Define analysis sample
//----------------------------------

gen sample_public = !missing(ln_demand, ln_oil_price)
label variable sample_public "Sample with non-missing public data variables"

//----------------------------------
* 9. Save analysis dataset
//----------------------------------

save "$processed/tanker_monthly_public_analysis.dta", replace