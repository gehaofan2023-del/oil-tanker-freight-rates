/********************************************************************
Project: Oil Tanker Freight Rates and Brokerage Activity
File: 03_descriptive_analysis.do
Purpose: Produce summary statistics, correlations, and descriptive plots
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
global figures "$root/figures"

capture mkdir "$results"
capture mkdir "$figures"

//-------------------------------
* 2. Load analysis dataset
//-------------------------------

use "$processed/tanker_monthly_public_analysis.dta", clear

* Check data structure
describe
summarize
list in 1/5

//-------------------------------
* 3. Summary statistics
//-------------------------------

summarize demand oil_price ln_demand ln_oil_price d_ln_demand d_ln_oil_price

* Export summary statistics to a log file
log using "$results/summary_statistics.log", replace

summarize demand oil_price ln_demand ln_oil_price d_ln_demand d_ln_oil_price

log close

//-------------------------------
* 4. Correlation matrix
//-------------------------------

correlate demand oil_price ln_demand ln_oil_price d_ln_demand d_ln_oil_price

log using "$results/correlation_matrix.log", replace

correlate demand oil_price ln_demand ln_oil_price d_ln_demand d_ln_oil_price

log close

//-------------------------------
* 5. Time-series plot: demand
//-------------------------------

twoway line demand mdate, ///
  title("Monthly Oil Demand") ///
  xtitle("Month") ///
  ytitle("Demand") ///
  name(fig_demand, replace)
  
graph export "$figures/monthly_oil_demand.png", replace

//-------------------------------
* 6. Time-series plot: oil price
//-------------------------------

twoway line oil_price mdate, ///
  title("Oil Price") ///
  xtitle("Month") ///
  ytitle("Oil Price") ///
  name(fig_oil_price, replace)
  
graph export "$figures/oil_price.png", replace

//-------------------------------
* 7. Time-series plot: log variables
//-------------------------------

twoway ///
  (line ln_demand mdate) ///
  (line ln_oil_price mdate), ///
  title("Log Demand and Log Oil Price") ///
  xtitle("Month") ///
  ytitle("Log value") ///
  legend(order(1 "Log demand" 2 "Log oil price")) ///
  name(fig_log_series, replace)

graph export "$figures/log_demand_oil_price.png", replace

//-------------------------------
* 8. Time-series plot: first differences
//-------------------------------

twoway ///
  (line d_ln_demand mdate) ///
  (line d_ln_oil_price mdate), ///
  title("First Differences of Log Variables") ///
  xtitle("Month") ///
  ytitle("First difference") ///
  legend(order(1 "Δ log demand" 2 "Δ log oil price")) ///
  name(fig_diff_series, replace)
  
graph export "$figures/diff_log_demand_oil_price.png", replace