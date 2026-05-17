/********************************************************************
Project: Oil Tanker Freight Rates and Brokerage Activity
File: 04_regression_analysis.do
Purpose: Estimate baseline regressions and simple robustness checks
Author: Haofan Ge
********************************************************************/

clear all
set more off

//-------------------------------
* 1. Set paths
//-------------------------------

global root "."
global data "$root/data"
global processed "$data/processed"
global results "$root/results"

capture mkdir "$results"

//-------------------------------
* 2. Load analysis dataset
//-------------------------------

use "$processed/tanker_monthly_public_analysis.dta", clear

* Check data structure
describe
summarize
list in 1/5

//-------------------------------
* 3. Set monthly time-series structure
//-------------------------------

format mdate %tm
sort mdate
tsset mdate

//-------------------------------
* 4. Baseline level regressions
//-------------------------------

log using "$results/regression_level_results.log", replace

* Model 1: simple relationship between demand and oil price
reg ln_oil_price ln_demand if sample_public == 1

* Model 2: lagged demand
reg ln_oil_price L1_ln_demand if sample_public == 1

* Model 3: include both current and lagged demand
reg ln_oil_price ln_demand L1_ln_demand if sample_public == 1

log close

//-------------------------------
* 5. First-difference regressions
//-------------------------------

log using "$results/regression_difference_results.log", replace

* Model 4: short-run relationship using first differences
reg d_ln_oil_price d_ln_demand if sample_public == 1

* Model 5: lagged short-run relationship
reg d_ln_oil_price L.d_ln_demand if sample_public == 1

* Model 6: current and lagged first differences
reg d_ln_oil_price d_ln_demand L.d_ln_demand if sample_public == 1

log close

//-------------------------------
* 6. Robustness checks
//-------------------------------

log using "$results/regression_robustness_checks.log", replace

* Newey-West standard errors for level specification
newey ln_oil_price ln_demand if sample_public == 1, lag(1)

* Newey-West standard errors for first-difference specification
newey d_ln_oil_price d_ln_demand if sample_public == 1, lag(1)

* Alternative lag length
newey d_ln_oil_price d_ln_demand if sample_public == 1, lag(3)

log close

//-------------------------------
* 7. Notes
//-------------------------------

* These regressions are exploratory and are intended to document
* the empirical workflow. The full freight-rate specification will
* include freight rates, fleet capacity, fixtures, demand, and oil prices
* once all restricted datasets are added to the project.
