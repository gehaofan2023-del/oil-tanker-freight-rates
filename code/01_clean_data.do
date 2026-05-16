/**********************************************
Project: Oil Tanker Freight Rates and Brokerage Activity
File: 01_clean_data.do
Purpose: Import and clean raw data files
Author: Haofan Ge
***********************************************/

clear all
set more off

//-------------------------------
* 1. Set paths
//-------------------------------

global root "."
global data "$root/data"
global raw "$data/raw"
global processed "$data/processed"

capture mkdir "$processed"

//--------------------------------
* 2. Clean oil price data
//--------------------------------

import delimited  "$raw/oil_price.csv", clear

* inspect variable names and structure
describe
summarize
list in 1/5

* Rename variables
rename DATE date
rename DCOILWTICO oil_price

* Convert date to monthly date
* If date is a daily string such as "2010-01-01":
gen daily_Date = date(date, "YMD")
format daily_date %td
gen mdate = mofd(daily_date)
format mdate %tm

* If date is already monthly string such as "2020-01":
gen mdate = monthly(date, "YM")
format mdate %tm

* Keep relevant variables
keep mdate oil_price

* Drop missing observations
drop if missing(mdate)
drop if missing(oil_price)

* Sort and save
sort mdate
save "$processed/oil_price_clean.dta", replace

*-----------------------------------
* 3. Clean demand data
*-----------------------------------

import delimited "$raw/demand.csv", clear

* Inspect variable names and structure
describe
summarize
list in 1/5

* Rename variables
rename period date
rename trade_value demand
rename quantity demand

* Convert date to monthly date
gen mdate = monthly(date, "YM")
format mdate %tm

* Keep relevant variables
keep mdate demand

* Drop missing observations
drop if missing(mdate)
drop if missing(demand)

* Sort and save
sort mdate
save "$processed/demand_clean.dta", replace

