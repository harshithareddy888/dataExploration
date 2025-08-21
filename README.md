# dataExploration
## Overview

This project explores global COVID-19 data using SQL Server.
The script (DataExploration1.sql) performs queries and aggregations on two datasets:

- newCovidDeaths – contains information on COVID-19 deaths by location, date, and population.

- covidVaccinations – contains data on vaccinations administered across countries/regions.

The goal is to analyze infection trends, death rates, and vaccination progress at both global and country levels.

## Datasets

- newCovidDeaths

Columns: location, date, population, total_cases, new_cases, total_deaths, new_deaths

Key insight: Tracks spread and severity of COVID-19 per region.

- covidVaccinations

Columns: location, date, new_vaccinations, total_vaccinations, people_vaccinated, people_fully_vaccinated

Key insight: Tracks vaccination rollout over time.

Both datasets were originally imported from CSV/Excel and loaded into SQL Server tables for querying.
