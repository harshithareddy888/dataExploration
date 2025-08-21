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

## Features of the SQL Script

### Basic Data Exploration

1. Inspect total cases, deaths, and population by country.

2. Calculate death percentage = (total_deaths / total_cases) * 100.

3. Calculate infection percentage = (total_cases / population) * 100.

### Aggregations

1. Find the highest infection count per country.

2. Identify countries with the highest death counts.

3. Summarize global numbers across all regions.

### Vaccination Analysis

1. Join covidVaccinations with newCovidDeaths by location and date.

2. Compute rolling totals of vaccinations by country.

3. Estimate percentage of population vaccinated.

## How to Run

- Import the datasets into SQL Server:

    1 newCovidDeaths

    2.covidVaccinations

- Open DataExploration1.sql in SQL Server Management Studio (SSMS).

- Select your database (e.g., PortifolioProjects) in the SSMS dropdown.

- Execute the script to run the queries.

- Results will be displayed in the Results/Message tabs.
