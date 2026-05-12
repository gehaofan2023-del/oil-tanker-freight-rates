# Oil Tanker Freight Rates and Brokerage Activity

## Project Overview

This project studies how oil tanker freight rates are related to market demand, fleet capacity, oil prices, and brokerage activity. The goal is to understand freight rate formation in the oil tanker shipping market and to explore whether brokerage-related market activity helps explain freight rate movements after controlling for demand and supply fundamentals.

This project is based on my spring research work on the oil tanker shipping market.

## Research Question

How are oil tanker freight rates related to demand, fleet capacity, oil prices, and brokerage activity?

More specifically, this project asks whether brokerage activity, proxied by market fixtures, contains useful information about freight rate movements beyond standard market fundamentals.

## Data

The project uses data from multiple sources:

- **Freight rates:** oil tanker freight rate data from Clarksons
- **Demand:** monthly oil trade / shipping demand data from UN Comtrade
- **Supply:** tanker fleet capacity data from Clarksons
- **Brokerage activity:** fixtures data from Clarksons
- **Oil prices:** crude oil price data from FRED

## Variables

- **Freight rate:** the main outcome variable, measuring tanker freight market conditions
- **Demand:** monthly oil trade or shipping demand
- **Fleet capacity:** tanker supply, measured by fleet size or deadweight tonnage
- **Fixtures:** number of signed spot contracts, used as a proxy for market activity and brokerage-related matching
- **Oil price:** crude oil price, used as a control for market conditions and cost-related factors

## Empirical Strategy

The baseline empirical specification relates freight rates to demand, fleet capacity, fixtures, and oil prices:

```text
log(Freight Rate_t) = α + β1 log(Demand_t) + β2 log(Fleet_t) + β3 log(Fixtures_t) + β4 log(Oil Price_t) + ε_t
