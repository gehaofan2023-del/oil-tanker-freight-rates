/********************************************************************
Project: Oil Tanker Freight Rates and Brokerage Activity
File: 05_make_figures.do
Purpose: Export final figures for project presentation
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
global figures "$root/figures"

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
* 3. Set monthly time-series structure
//-------------------------------

format mdate %tm
sort mdate
tsset mdate

//-------------------------------
* 4. Figure 1: Monthly oil demand
//-------------------------------

twoway line demand mdate, ///
    title("Monthly Oil Demand") ///
    xtitle("Month") ///
    ytitle("Demand") ///
    name(fig1_demand, replace)

graph export "$figures/figure1_monthly_oil_demand.png", replace

*--------------------------------------------------
* 5. Figure 2: Oil price
*--------------------------------------------------

twoway line oil_price mdate, ///
    title("Oil Price") ///
    xtitle("Month") ///
    ytitle("Oil Price") ///
    name(fig2_oil_price, replace)

graph export "$figures/figure2_oil_price.png", replace

*--------------------------------------------------
* 6. Figure 3: Log demand and log oil price
*--------------------------------------------------

twoway ///
    (line ln_demand mdate) ///
    (line ln_oil_price mdate), ///
    title("Log Demand and Log Oil Price") ///
    xtitle("Month") ///
    ytitle("Log value") ///
    legend(order(1 "Log demand" 2 "Log oil price")) ///
    name(fig3_log_series, replace)

graph export "$figures/figure3_log_demand_oil_price.png", replace

*--------------------------------------------------
* 7. Figure 4: First differences of log variables
*--------------------------------------------------

twoway ///
    (line d_ln_demand mdate) ///
    (line d_ln_oil_price mdate), ///
    title("First Differences of Log Demand and Oil Price") ///
    xtitle("Month") ///
    ytitle("First difference") ///
    legend(order(1 "Delta log demand" 2 "Delta log oil price")) ///
    name(fig4_diff_series, replace)

graph export "$figures/figure4_diff_log_demand_oil_price.png", replace

*--------------------------------------------------
* 8. Figure 5: Scatter plot of log demand and log oil price
*--------------------------------------------------

twoway ///
    (scatter ln_oil_price ln_demand) ///
    (lfit ln_oil_price ln_demand), ///
    title("Log Oil Price and Log Demand") ///
    xtitle("Log monthly oil demand") ///
    ytitle("Log oil price") ///
    legend(order(1 "Observed values" 2 "Fitted line")) ///
    name(fig5_scatter_log, replace)

graph export "$figures/figure5_scatter_log_oil_price_demand.png", replace

*--------------------------------------------------
* 9. Figure 6: Scatter plot of first differences
*--------------------------------------------------

twoway ///
    (scatter d_ln_oil_price d_ln_demand) ///
    (lfit d_ln_oil_price d_ln_demand), ///
    title("Changes in Oil Price and Demand") ///
    xtitle("Delta log monthly oil demand") ///
    ytitle("Delta log oil price") ///
    legend(order(1 "Observed changes" 2 "Fitted line")) ///
    name(fig6_scatter_diff, replace)

graph export "$figures/figure6_scatter_diff_oil_price_demand.png", replace

*--------------------------------------------------
* 10. Notes
*--------------------------------------------------

* These figures are intended for project presentation and GitHub display.
* Once freight rate, fleet capacity, and fixtures data are added, additional
* figures should be created for the full oil tanker freight-rate analysis.